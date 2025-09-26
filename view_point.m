clc
clear
%% ----读取单一stl模型----
STLfilename = "油箱底板.STL";
% STLfilename = "C:\Users\Y\Desktop\weld run\robot\2024-12-15\test_MOD\类型1.STL";
Mold_DP = stlread(STLfilename);
Mold_DP1 = fegeometry(STLfilename,AllowSelfIntersections=1,FeatureAngle=10);
pdegplot(Mold_DP1)
xlim([min(Mold_DP1.Vertices(:, 1)) max(Mold_DP1.Vertices(:, 1))]);
ylim([min(Mold_DP1.Vertices(:, 2)) max(Mold_DP1.Vertices(:, 2))]);
zlim([min(Mold_DP1.Vertices(:, 3)) max(Mold_DP1.Vertices(:, 3))]);

%% ----获取模型的相关信息----
vertices = Mold_DP1.Vertices;                      % 模型顶点
triangular_patch = Mold_DP.ConnectivityList;       % 模型三角面片
triangular_point = Mold_DP.Points;                 % 三角面片3点
triangular_norm = Mold_DP.faceNormal;              % 三角面片的法向量

%% ----计算三角面片的重心和平面方程----
% - heatpoint(三角平面的重心)
% - plane_xs(平面方程系数)
[heatpoint,plane_xs] = PlaneEquation(triangular_patch,triangular_point,triangular_norm);

%% ----显示三角面片和法向量（检测是否产生重叠）----
figure
hold on
patch('Faces',triangular_patch,'Vertices',triangular_point,'FaceColor',[0.5 0.5 0.5],'EdgeColor','black')
quiver3(heatpoint(:,1),heatpoint(:,2),heatpoint(:,3),triangular_norm(:,1),triangular_norm(:,2),triangular_norm(:,3));
%% ----计算最小外接立方体和显示----
figure
hold on
pdegplot(Mold_DP1)
[pos,centerCoord,length] = BoundingBox(vertices);
showShape('cuboid',pos,'Color','yellow','Opacity',0.1);
%% ----{1}椭球体视角点分布----
[Ellx,Elly,Ellz] = EllipsoidView(vertices);
figure
hold on
s = surf(Ellx, Elly, Ellz);
s.EdgeColor = 'none';
s.FaceAlpha = 0.5;
pdegplot(Mold_DP1)
%% ----{2}自适应视角点分布----

%% ----三角面片联合归一-----
[collection_plane_xu]=PlaneUnified(plane_xs);
%% ----计算相邻三角面片边界点-----
boundary = boundary90(triangular_patch,triangular_norm);
forj = size(boundary);
figure
for j = 1:forj(1)
    point_A = triangular_point(boundary(j,1),:);
    point_B = triangular_point(boundary(j,2),:);
    hold on
    boundary_xt = plot3([point_A(1), point_B(1)], [point_A(2), point_B(2)], [point_A(3), point_B(3)], '-o');
    boundary_xt.LineWidth = 2;
    boundary_xt.Color = 'red';
end
pdegplot(Mold_DP1)
%% ----单面网格映射投影-----
figure
% 网格线的间隔
interval = 20;
% 平面偏移量
deviation = 500;
[PP_XY_Zmax,PP_XY_Zmin,PP_XZ_Ymax,PP_XZ_Ymin,PP_YZ_Xmax,PP_YZ_Xmin] = ProjectionPoint(vertices,interval,deviation);

%% ----单面网格交叉映射-----
figure
hold on
MappingCross_deviation = deviation+100;
[MC_XY_Zmax,MC_XY_Zmin,MC_XZ_Ymax,MC_XZ_Ymin,MC_YZ_Xmax,MC_YZ_Xmin] = MappingCross(vertices,interval,MappingCross_deviation);

%% ----单面棋盘格对应投射-----
figure
hold on
ChessboardPattern_deviation = deviation+200;
[CP_XY_Zmax,CP_XY_Zmin,CP_XZ_Ymax,CP_XZ_Ymin,CP_YZ_Xmax,CP_YZ_Xmin] = ChessboardPattern(vertices,interval,ChessboardPattern_deviation);

%% ----拟定焊缝轨迹提取-------
figure
hold on
[Proposed_Weld_Seam] = WeldSeamExtraction(triangular_patch,triangular_point,triangular_norm,heatpoint,boundary);
PWS = size(Proposed_Weld_Seam);
pdegplot(Mold_DP1)
for P = 1:PWS(1)
    point_A = triangular_point(Proposed_Weld_Seam(P,1),:);
    point_B = triangular_point(Proposed_Weld_Seam(P,2),:);
    hold on
    Weld_Seam_xt = plot3([point_A(1), point_B(1)], [point_A(2), point_B(2)], [point_A(3), point_B(3)], '-diamond');
    Weld_Seam_xt.LineWidth = 2;
    Weld_Seam_xt.Color = 'blue';
end
fprintf ('提取出的焊缝中数量为：%f.\n',PWS(1));

%% ----鼠标交互删除和添加焊缝-----





