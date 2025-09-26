clc
clear
load("类型1.mat","Proposed_Weld_Seam")
%% ----读取单一stl模型----
STLfilename = "C:\Users\Y\Desktop\weld run\robot\2024-12-22\test_MOD\类型1.STL";
Mold_DP = stlread(STLfilename);
Mold_DP1 = fegeometry(STLfilename,AllowSelfIntersections=1,FeatureAngle=10);

%% ----获取模型的相关信息----
vertices = Mold_DP1.Vertices;                      % 模型顶点
triangular_patch = Mold_DP.ConnectivityList;       % 模型三角面片
triangular_point = Mold_DP.Points;                 % 三角面片3点
triangular_norm = Mold_DP.faceNormal;              % 三角面片的法向量
fenduan_weld_seam = Binary_Connections(Proposed_Weld_Seam);
colors = lines(length(fenduan_weld_seam));
pdegplot(Mold_DP1)
for i = 1:length(fenduan_weld_seam)
    weld_seam = fenduan_weld_seam{i,1};

    currentColor = colors(i, :);
    for j = 1:length(weld_seam)
        point_A = triangular_point(weld_seam(j,1),:);
        point_B = triangular_point(weld_seam(j,2),:);
        hold on
        Weld_Seam_xt = plot3([point_A(1), point_B(1)], [point_A(2), point_B(2)], [point_A(3), point_B(3)], '-diamond');
        Weld_Seam_xt.LineWidth = 2;
        Weld_Seam_xt.Color = currentColor;
    end
end
xlim([min(Mold_DP1.Vertices(:, 1)) max(Mold_DP1.Vertices(:, 1))]);
ylim([min(Mold_DP1.Vertices(:, 2)) max(Mold_DP1.Vertices(:, 2))]);
zlim([min(Mold_DP1.Vertices(:, 3)) max(Mold_DP1.Vertices(:, 3))]);