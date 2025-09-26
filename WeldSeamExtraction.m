function [Proposed_Weld_Seam] = WeldSeamExtraction(inputArg1,inputArg2,inputArg3,inputArg4,inputArg5)
% 焊缝轨迹提取函数
% (1)triangular_patch模型三角面片
% (2)triangular_point三角面片3点
% (3)triangular_norm三角面片法向量
% (4)heatpoint三角面片中心点
% (5)boundary模型的边界
% 输入参数
triangular_patch = inputArg1;       % 模型三角面片
triangular_point = inputArg2;       % 三角面片3点
triangular_norm = inputArg3;        % 三角面片法向量
heatpoint = inputArg4;              % 三角面片中心点
boundary = inputArg5;               % 模型的边界
% 去掉重复的存在的边界线
sortedRows = sort(boundary, 2);
uniqueRows = unique(sortedRows, 'rows');

forj = size(uniqueRows);
Proposed_Weld_Seam = [];            % 创建焊缝轨迹空集
for i = 1:forj(1)
    % 获取边界线的两个段点
    point_A = triangular_point(uniqueRows(i,1),:);
    point_B = triangular_point(uniqueRows(i,2),:); 

    % 获取边界线平行的向量
    vectorAB = [point_B(1) - point_A(1), point_B(2) - point_A(2), point_B(3) - point_A(3)];
    norm_v = norm(vectorAB);
    u = vectorAB / norm_v;

    % 根据向量和边界段点创建平面方程
    A = u(1);
    B = u(2);
    C = u(3);
    x0 = point_A(1);
    y0 = point_A(2);
    z0 = point_A(3);
    D = -(A * x0 + B * y0 + C * z0);

    % 获取边界线相邻两个面的中心点和平面法向量
    rows_with_l1 = any(triangular_patch == uniqueRows(i,1), 2) & any(triangular_patch == uniqueRows(i,2), 2);
    XL_heatpoint = heatpoint(rows_with_l1,:);
    XL_norm = triangular_norm(rows_with_l1,:);

    % 根据段点进行法向量投影（分别取为A和B两个平面）
    %-------------------------------------------------------A面投影点
    X_A = XL_heatpoint(1,1);
    Y_A = XL_heatpoint(1,2);
    Z_A = XL_heatpoint(1,3);
    % 采用参数方程的形式
    t_A = -(A*X_A + B*Y_A + C*Z_A + D)/(A^2+B^2+C^2);

    % 计算投影点坐标
    TY_A_X = A*t_A+X_A ;  % 或者 x1 = v_projected(1) + 0 (原点)
    TY_A_Y = B*t_A+Y_A ;  % 或者 y1 = v_projected(2) + 0 (原点)
    TY_A_Z = C*t_A+Z_A ;  % 或者 z1 = v_projected(3) + 0 (原点)

    %------------------------------------------------------B面投影点
    X_B = XL_heatpoint(2,1);
    Y_B = XL_heatpoint(2,2);
    Z_B = XL_heatpoint(2,3);
    t_B = -(A*X_B + B*Y_B + C*Z_B + D)/(A^2+B^2+C^2);


    % 计算投影点坐标
    TY_B_X = A*t_B+X_B ;  % 或者 x1 = v_projected(1) + 0 (原点)
    TY_B_Y = B*t_B+Y_B ;  % 或者 y1 = v_projected(2) + 0 (原点)
    TY_B_Z = C*t_B+Z_B ;  % 或者 z1 = v_projected(3) + 0 (原点)

    % 根据投影点和根据三角平面的方程的
    % ------------------------------创建A面法向量线段，根据投影点确定终止点
    XUA = XL_norm(1,1);
    YUA = XL_norm(1,2);
    ZUA = XL_norm(1,3);

    t = 1000000;
    % 计算直线上的点
    A_X_gold = TY_A_X + t * XUA;
    A_Y_gold = TY_A_Y + t * YUA;
    A_Z_gold = TY_A_Z + t * ZUA;
    % ------------------------------创建B面法向量线段，根据投影点确定终止点
    XUB = XL_norm(2,1);
    YUB = XL_norm(2,2);
    ZUB = XL_norm(2,3);

    % 计算直线上的点
    B_X_gold = TY_B_X + t * XUB;
    B_Y_gold = TY_B_Y + t * YUB;
    B_Z_gold = TY_B_Z + t * ZUB;
    % 整合出线段的起始点与结束点
    A_S = [TY_A_X, TY_A_Y, TY_A_Z];
    A_G = [A_X_gold, A_Y_gold, A_Z_gold];
    B_S = [TY_B_X, TY_B_Y, TY_B_Z];
    B_G = [B_X_gold, B_Y_gold, B_Z_gold];

    % 根据延长线，确定线段的起始与终止点
    line1.startPoint = A_S;
    line1.endPoint = A_G;
    line2.startPoint = B_S;
    line2.endPoint = B_G;

    % 判断两延长线段是否相交
    tolerance = 1.0e-6;
    sta = judge_two_line_segment_intersection(line1, line2, tolerance);
    if sta == 1
        Proposed_Weld_Seam = [Proposed_Weld_Seam;uniqueRows(i,:)];
        % disp('两线段相交')
    else
        % disp('两线段不相交')
    end
end