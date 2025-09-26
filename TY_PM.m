function [outputArg1] = TY_PM(inputArg1,inputArg2)
% 将一个点投影到平面上，输出投影点
%   
% 需投影点
point = inputArg1;
% 投影平面系数
plane = inputArg2;
%% 点到平面的投影点

A = plane(1);
B = plane(2);
C = plane(3);
D = plane(4);

% 需要投影的点
X = point(1,1);
Y = point(1,2);
Z = point(1,3);

% 采用参数方程的形式
t = -(A*X + B*Y + C*Z + D)/(A^2+B^2+C^2);

% 计算投影点坐标
TY_X = A*t+X ;  % 或者 x1 = v_projected(1) + 0 (原点)
TY_Y = B*t+Y ;  % 或者 y1 = v_projected(2) + 0 (原点)
TY_Z = C*t+Z ;  % 或者 z1 = v_projected(3) + 0 (原点)

% 输出投影点
outputArg1 = [TY_X,TY_Y,TY_Z];
end