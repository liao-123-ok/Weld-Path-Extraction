%% ----计算三角面的重心及平面方程的(A,B,C,D)的系数
%% ----(I1)三角面片三点面信息
%% ----(I2)三角顶点信息
%% ----(O1)三角面的重心
%% ----(O2)三角面方程系数
function [outputArg1,outputArg2] = PlaneEquation(inputArg1,inputArg2,inputArg3)
% 计算三角面的重心
% 计算该三角面片的平面方程的(A,B,C,D)的系数
centroids = [];
Plane_xs = [];
Mold_DP.ConnectivityList = inputArg1;
Mold_DP.Points = inputArg2;
N = inputArg3;
for i = 1:length(Mold_DP.ConnectivityList)
    points = Mold_DP.ConnectivityList(i,:);
    point1 = Mold_DP.Points(points(1),:);
    point2 = Mold_DP.Points(points(2),:);
    point3 = Mold_DP.Points(points(3),:);
    % 计算三角面的重心
    centroid = (point1 + point2 + point3) / 3;
    centroids = [centroids;centroid];
    A = N(i,1);
    B = N(i,2);
    C = N(i,3);
    D = -(A*centroid(1)+B*centroid(2)+C*centroid(3));
    Plane_xs = [Plane_xs;A,B,C,D];
end
outputArg1 = centroids;
outputArg2 = Plane_xs;
end