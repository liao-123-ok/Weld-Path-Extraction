%% -----创建OBB包围盒的最小立方体-----
%% -----（I1）模型的所以顶点
%% -----（O1）包围盒立方体显示
%% -----（O2）包围盒立方体中心坐标
%% -----（O3）包围盒立方体长宽高
function [outputArg1,outputArg2,outputArg3] = BoundingBox(inputArg1)
% 创建OBB包围盒
points = inputArg1;
% 1、计算顶点质心;
centroid = mean(points,1);
% 找到x, y, z的最小值和最大值 
xMin = min(points(:, 1));  
xMax = max(points(:, 1));  
yMin = min(points(:, 2));  
yMax = max(points(:, 2));  
zMin = min(points(:, 3));  
zMax = max(points(:, 3)); 
% 计算模型在xyz方向上的取值范围
dx = xMax - xMin;
dy = yMax - yMin;
dz = zMax - zMin;
pos = [xMin+dx/2, yMin+dy/2, zMin+dz/2, dx, dy, dz, 0, 0, 0];
centerCoord = [(xMax + xMin)/2 (yMax + yMin)/2 (zMax + zMin)/2];
% 立方体的输出
outputArg1 = pos;
outputArg2 = centerCoord;
outputArg3 = [dx dy dz];
end