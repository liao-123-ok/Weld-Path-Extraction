clc
clear
%实验测试用图程序
tic;
%% ----读取单一stl模型----
[fileName, pathName] = uigetfile('*.*', '请选择文件');
% STLfilename ="C:\Users\Y\Desktop\MOLD\型材框架.STL";
STLfilename = fullfile(pathName, fileName);
Mold_DP = stlread(STLfilename);
Mold_DP1 = fegeometry(STLfilename,AllowSelfIntersections=1,FeatureAngle=10);
vertices = Mold_DP1.Vertices;                      % 模型顶点
triangular_patch = Mold_DP.ConnectivityList;       % 模型三角面片
triangular_point = Mold_DP.Points;                 % 三角面片3点
triangular_norm = Mold_DP.faceNormal;
pdegplot(Mold_DP1,FaceAlpha=1)
xlim([min(Mold_DP1.Vertices(:, 1)) max(Mold_DP1.Vertices(:, 1))]);
ylim([min(Mold_DP1.Vertices(:, 2)) max(Mold_DP1.Vertices(:, 2))]);
zlim([min(Mold_DP1.Vertices(:, 3)) max(Mold_DP1.Vertices(:, 3))]);

%% ----获取三角面片的平面方程----
[heatpoint,plane_xs] = PlaneEquation(triangular_patch,triangular_point,triangular_norm);

%% ----获取模型边界----
% 型边界线----
min_angle = 10;
boundary = boundary90(triangular_patch,triangular_norm,min_angle);
sorted_A_asc = sort(boundary, 2); % 沿着第2维度（行）排序
[boundary, ~, ic1] = unique(sorted_A_asc, 'rows');


%% ----初步焊接轨迹提取-----
[Proposed_Weld_Seam] = WeldSeamExtraction(triangular_patch,triangular_point,triangular_norm,heatpoint,boundary);

%% ----再次轨迹筛选-----
Weld_Seam_SY = [];
for i = 1:size(Proposed_Weld_Seam,1)
    rows_with = any(triangular_patch == Proposed_Weld_Seam(i,1), 2) & any(triangular_patch == Proposed_Weld_Seam(i,2), 2);
    plane_sum = plane_xs(rows_with,:);
    % 获取两个焊缝的平面方程
    plane1 = plane_sum(1,:);
    plane2 = plane_sum(2,:);
    % 获取平面的法向量
    plane1_norm = plane1(1:3);
    plane2_norm = plane2(1:3);
    % 转为相反法向量
    opposite_plane1_norm = -plane1_norm;
    opposite_plane2_norm = -plane2_norm;
    % 找到所有相反法向量的平行面的索引
    matchingIndices_plane1 = [];
    for j1 = 1:size(triangular_norm, 1)
        if isequal(triangular_norm(j1, :), opposite_plane1_norm)
            matchingIndices_plane1 = [matchingIndices_plane1; j1]; % 将匹配行的索引添加到数组中
        end
    end
    matchingIndices_plane2 = [];
    for j2 = 1:size(triangular_norm, 1)
        if isequal(triangular_norm(j2, :), opposite_plane2_norm)
            matchingIndices_plane2 = [matchingIndices_plane2; j2]; % 将匹配行的索引添加到数组中
        end
    end
    % 输出所有相反法向量的平面
    opposite_plane1 = plane_xs(matchingIndices_plane1,:);
    opposite_plane2 = plane_xs(matchingIndices_plane2,:);
    % 将所有相反法向量的平面系数取反
    negtion_opposite_plane1 = -opposite_plane1;
    negtion_opposite_plane2 = -opposite_plane2;
    distance1_set = [];
    for t1 = 1:size(negtion_opposite_plane1,1)
        distance1 = (plane1(4)-negtion_opposite_plane1(t1,4))/sqrt(plane1(1).^2 + plane1(2).^2 + plane1(3).^2);
        distance1_set =[distance1_set;distance1];
    end
    distance2_set = [];
    for t2 = 1:size(negtion_opposite_plane2,1)
        distance2 = (plane2(4)-negtion_opposite_plane2(t2,4))/sqrt(plane2(1).^2 + plane2(2).^2 + plane2(3).^2);
        distance2_set =[distance2_set;distance2];
    end
    % 找到每个平面距离参考平面的最小距离
    % 参考plane1的最小法向量相反平面距离
    positiveIndices_distance1_set = distance1_set > 0;
    positiveNumbers_distance1_set = distance1_set(positiveIndices_distance1_set);
    min_positiveNumbers_distance1_set = min(positiveNumbers_distance1_set);
    % 参考plane2的最小法向量相反平面距离
    positiveIndices_distance2_set = distance2_set > 0;
    positiveNumbers_distance2_set = distance2_set(positiveIndices_distance2_set);
    min_positiveNumbers_distance2_set = min(positiveNumbers_distance2_set);
    % 判定最小相反平面的距离判断
    % 调整方钢尺寸大小来删除内部焊接线段
    FG = 100;
    if isempty(min_positiveNumbers_distance1_set)
        min_positiveNumbers_distance1_set = FG+1;
    end
    if isempty(min_positiveNumbers_distance2_set)
        min_positiveNumbers_distance2_set = FG+1;
    end
    logicalArray = [min_positiveNumbers_distance1_set, min_positiveNumbers_distance2_set] <= FG;
    if all(logicalArray)% 注意切换all或any可以调整不同筛选效果
        Weld_Seam_SY = [Weld_Seam_SY;i];
    end
end
%% 再次筛选
PASS_WELD = Proposed_Weld_Seam(Weld_Seam_SY,:);
point_E = PASS_WELD(:,1);
point_F = PASS_WELD(:,2);
for u1 = 1:size(point_E,1)
    [row1, col1] = find(Proposed_Weld_Seam == point_E(u1));
    Weld_Seam_SY = [Weld_Seam_SY;row1];
end
for u2 = 1:size(point_F,1)
    [row2, col2] = find(Proposed_Weld_Seam == point_F(u2));
    Weld_Seam_SY = [Weld_Seam_SY;row2];
end
%% 过滤出是筛出的焊缝
Weld_Seam_SY = sort(Weld_Seam_SY);
row_indices = setdiff(1:size(Proposed_Weld_Seam, 1), Weld_Seam_SY);
Weld_Seam = Proposed_Weld_Seam(row_indices, :);

%%----
diff_set_sorted1 = setdiff(Proposed_Weld_Seam, Weld_Seam, 'rows');




% 
BOU1 = size(boundary,1);
BOU2 = size(Proposed_Weld_Seam,1);
BOU3 = size(Weld_Seam,1);
BOU4 = size(diff_set_sorted1,1);
fprintf ('提取出的边界中数量为：%f.\n',BOU1);
fprintf ('提取出初步轨迹数量为：%f.\n',BOU2);
fprintf ('提取出筛选轨迹数量为：%f.\n',BOU3);
fprintf ('提取出筛除轨迹数量为：%f.\n',BOU4);
zhengti = 0;
for A1 = 1:size(Weld_Seam,1)
    point_A = triangular_point(Weld_Seam(A1,1),:);
    point_B = triangular_point(Weld_Seam(A1,2),:);
    distance = sqrt(sum((point_A - point_B).^2));
    zhengti = zhengti + distance;
end
fprintf ('提取出筛选轨迹长度为：%f.\n',zhengti);

elapsed_time = toc;
fprintf('代码执行耗时: %.6f 秒\n', elapsed_time);
%% ------显示模型中的轨迹

figure('Units', 'inches', 'Position', [0.5, 0.5, 20, 10], 'Color', 'w');
pdegplot(Mold_DP1,FaceAlpha=1)
xlim([min(Mold_DP1.Vertices(:, 1)) max(Mold_DP1.Vertices(:, 1))]);
ylim([min(Mold_DP1.Vertices(:, 2)) max(Mold_DP1.Vertices(:, 2))]);
zlim([min(Mold_DP1.Vertices(:, 3)) max(Mold_DP1.Vertices(:, 3))]);
% 显示筛除的轨迹
% hold on
% PWS = size(diff_set_sorted1);
% for P = 1:PWS(1)
%     point_A = triangular_point(diff_set_sorted1(P,1),:);
%     point_B = triangular_point(diff_set_sorted1(P,2),:);
%     hold on
%     Weld_Seam_xt2 = plot3([point_A(1), point_B(1)], [point_A(2), point_B(2)], [point_A(3), point_B(3)], '-');
%     Weld_Seam_xt2.LineWidth = 3;
%     Weld_Seam_xt2.Color = '#B2D732';
% end
hold on
for K = 1:size(Weld_Seam,1)
    point_A = triangular_point(Weld_Seam(K,1),:);
    point_B = triangular_point(Weld_Seam(K,2),:);
    hold on
    Weld_Seam_xt1 = plot3([point_A(1), point_B(1)], [point_A(2), point_B(2)], [point_A(3), point_B(3)], '-');
    Weld_Seam_xt1.LineWidth = 3;
    Weld_Seam_xt1.Color = "#fc5185";
    % pause(0.5);
end
% 显示筛选边界
diff_set_sorted = setdiff(boundary, Proposed_Weld_Seam, 'rows');
hold on
for R = 1:size(diff_set_sorted,1)
    point_A = triangular_point(diff_set_sorted(R,1),:);
    point_B = triangular_point(diff_set_sorted(R,2),:);
    hold on
    Weld_Seam_xt = plot3([point_A(1), point_B(1)], [point_A(2), point_B(2)], [point_A(3), point_B(3)], '-');
    Weld_Seam_xt.LineWidth = 3;
    Weld_Seam_xt.Color = "#3f72af";
    % pause(0.5);
end
view(-37.5, 30); 
camva('manual'); % 锁定视角
% legend([Weld_Seam_xt,Weld_Seam_xt1, Weld_Seam_xt2], {'模型特征边界线','模型焊缝轨迹线', '筛选不符合轨迹线'});