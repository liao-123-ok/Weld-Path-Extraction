%% -----创建椭球点阵分布----
%% -----（1）模型顶点

function [outputArg1,outputArg2,outputArg3] = EllipsoidView(inputArg1)

% 定义椭球体的参数
points = inputArg1;
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
% 确定椭球中心点
cx = (xMax + xMin)/2;
cy = (yMax + yMin)/2;
cz = (zMax + zMin)/2;
% 计算各轴的半轴
a = dx/2+abs(xMax);
b = dy/2+abs(yMax);
c = dz/2+abs(zMax);
[x, y, z] = ellipsoid(cx,cy,cz,a,b,c,80);
outputArg1 = x;
outputArg2 = y;
outputArg3 = z;
end