function [PP_XY_Zmax,PP_XY_Zmin,PP_XZ_Ymax,PP_XZ_Ymin,PP_YZ_Xmax,PP_YZ_Xmin] = ProjectionPoint(inputArg1,inputArg2,inputArg3)
%投影偏移量演示
%   此处显示详细说明
vertices = inputArg1;
% 网格线的间隔
interval = inputArg2;
% 平面偏移量
deviation = inputArg3;
% 找到x, y, z的最小值和最大值  
xMin = min(vertices(:, 1));  
xMax = max(vertices(:, 1));  
yMin = min(vertices(:, 2));  
yMax = max(vertices(:, 2));  
zMin = min(vertices(:, 3));  
zMax = max(vertices(:, 3)); 
re_PP_XY_Zmax = [];
re_PP_XY_Zmin = [];
re_PP_XZ_Ymax = [];
re_PP_XZ_Ymin = [];
re_PP_YZ_Xmax = [];
re_PP_YZ_Xmin = [];
%% ---------------------------------------------在xy轴平面的映射---z是zMax
% 定义网格的范围和分辨率
x_min = xMin;
x_max = xMax;
y_min = yMin;
y_max = yMax;
resolution = interval; % 网格线的间隔

% 使用 meshgrid 生成 X 和 Y 的坐标矩阵
[X, Y] = meshgrid(x_min:resolution:x_max, y_min:resolution:y_max);

% 创建一个常数值的 Z 矩阵，表示平面的高度
Z = (zMax+deviation) * ones(size(X));

% 使用 plot3 绘制网格线
% figure;
hold on;
% 绘制 X 方向上的网格线（在 Z = zMax 平面上）
for xi = 1:size(X, 2)
    plot3(X(:, xi), Y(:, xi), Z(:, xi), 'k', 'LineWidth', 0.5);
end
% 绘制 Y 方向上的网格线（在 Z = zMax 平面上）
for yi = 1:size(Y, 1)
    plot3(X(yi, :), Y(yi, :), Z(yi, :), 'k', 'LineWidth', 0.5);
end
% 计算网格中心点坐标
center_X = X(1:end-1, 1:end-1) + resolution/2;
center_Y = Y(1:end-1, 1:end-1) + resolution/2;
center_Z = (zMax+deviation) * ones(size(center_X));
% 输出网格中心点坐标
[num_rows, num_cols] = size(center_X);
for i = 1:num_rows
    for j = 1:num_cols
        re_PP_XY_Zmax = [re_PP_XY_Zmax;center_X(i, j), center_Y(i, j), center_Z(i, j)];
    end
end
PP_XY_Zmax = re_PP_XY_Zmax;

%% ---------------------------------------------在xy轴平面的映射---z是zMin
% 定义网格的范围和分辨率
x_min = xMin;
x_max = xMax;
y_min = yMin;
y_max = yMax;
resolution = interval; % 网格线的间隔

% 使用 meshgrid 生成 X 和 Y 的坐标矩阵
[X, Y] = meshgrid(x_min:resolution:x_max, y_min:resolution:y_max);

% 创建一个常数值的 Z 矩阵，表示平面的高度
Z = (zMin-deviation) * ones(size(X));

% 使用 plot3 绘制网格线
% figure;
hold on;
% 绘制 X 方向上的网格线（在 Z = zMin 平面上）
for xi = 1:size(X, 2)
    plot3(X(:, xi), Y(:, xi), Z(:, xi), 'k', 'LineWidth', 0.5);
end
% 绘制 Y 方向上的网格线（在 Z = zMin 平面上）
for yi = 1:size(Y, 1)
    plot3(X(yi, :), Y(yi, :), Z(yi, :), 'k', 'LineWidth', 0.5);
end
% 计算网格中心点坐标
center_X = X(1:end-1, 1:end-1) + resolution/2;
center_Y = Y(1:end-1, 1:end-1) + resolution/2;
center_Z = (zMin-deviation) * ones(size(center_X));
% 输出网格中心点坐标
[num_rows, num_cols] = size(center_X);
for i = 1:num_rows
    for j = 1:num_cols
        re_PP_XY_Zmin = [re_PP_XY_Zmin;center_X(i, j), center_Y(i, j), center_Z(i, j)];
    end
end
PP_XY_Zmin = re_PP_XY_Zmin;

%% ---------------------------------------------在xz轴平面的映射---y是yMax
% 定义网格的范围和分辨率
x_min = xMin;
x_max = xMax;
z_min = zMin;
z_max = zMax;
resolution = interval; % 网格线的间隔

% 使用 meshgrid 生成 X 和 Z 的坐标矩阵
[X, Z] = meshgrid(x_min:resolution:x_max, z_min:resolution:z_max);

% 创建一个常数值的 Y 矩阵，表示平面的高度
Y = (yMax+deviation) * ones(size(X));

% 使用 plot3 绘制网格线
% figure;
hold on;
% 绘制 X 方向上的网格线（在 Y = yMax 平面上）
for xi = 1:size(X, 2)
    plot3(X(:, xi), Y(:, xi), Z(:, xi), 'k', 'LineWidth', 0.5);
end
% 绘制 Y 方向上的网格线（在 Y = yMax 平面上）
for zi = 1:size(Z, 1)
    plot3(X(zi, :), Y(zi, :), Z(zi, :), 'k', 'LineWidth', 0.5);
end
% 计算网格中心点坐标
center_X = X(1:end-1, 1:end-1) + resolution/2;
center_Z = Z(1:end-1, 1:end-1) + resolution/2;
center_Y = (yMax+deviation) * ones(size(center_X));
% 输出网格中心点坐标
[num_rows, num_cols] = size(center_X);
for i = 1:num_rows
    for j = 1:num_cols
        re_PP_XZ_Ymax = [re_PP_XZ_Ymax;center_X(i, j), center_Y(i, j), center_Z(i, j)];
    end
end
PP_XZ_Ymax = re_PP_XZ_Ymax;

%% ---------------------------------------------在xz轴平面的映射---y是yMin
% 定义网格的范围和分辨率
x_min = xMin;
x_max = xMax;
z_min = zMin;
z_max = zMax;
resolution = interval; % 网格线的间隔

% 使用 meshgrid 生成 X 和 Z 的坐标矩阵
[X, Z] = meshgrid(x_min:resolution:x_max, z_min:resolution:z_max);

% 创建一个常数值的 Y 矩阵，表示平面的高度
Y = (yMin-deviation) * ones(size(X));

% 使用 plot3 绘制网格线
% figure;
hold on;
% 绘制 X 方向上的网格线（在 Y = yMin 平面上）
for xi = 1:size(X, 2)
    plot3(X(:, xi), Y(:, xi), Z(:, xi), 'k', 'LineWidth', 0.5);
end
% 绘制 Z 方向上的网格线（在 Y = yMin 平面上）
for zi = 1:size(Z, 1)
    plot3(X(zi, :), Y(zi, :), Z(zi, :), 'k', 'LineWidth', 0.5);
end
% 计算网格中心点坐标
center_X = X(1:end-1, 1:end-1) + resolution/2;
center_Z = Z(1:end-1, 1:end-1) + resolution/2;
center_Y = (yMin-deviation) * ones(size(center_X));
% 输出网格中心点坐标
[num_rows, num_cols] = size(center_X);
for i = 1:num_rows
    for j = 1:num_cols
        re_PP_XZ_Ymin = [re_PP_XZ_Ymin;center_X(i, j), center_Y(i, j), center_Z(i, j)];
    end
end
PP_XZ_Ymin = re_PP_XZ_Ymin;

%% ---------------------------------------------在yz轴平面的映射---x是xMax
% 定义网格的范围和分辨率
y_min = yMin;
y_max = yMax;
z_min = zMin;
z_max = zMax;
resolution = interval; % 网格线的间隔

% 使用 meshgrid 生成 X 和 Z 的坐标矩阵
[Y, Z] = meshgrid(y_min:resolution:y_max, z_min:resolution:z_max);

% 创建一个常数值的 Y 矩阵，表示平面的高度
X = (xMax+deviation) * ones(size(Y));

% 使用 plot3 绘制网格线
% figure;
hold on;
% 绘制 Y 方向上的网格线（在 X = xMax 平面上）
for yi = 1:size(Y, 2)
    plot3(X(:, yi), Y(:, yi), Z(:, yi), 'k', 'LineWidth', 0.5);
end
% 绘制 Z 方向上的网格线（在 X = xMax 平面上）
for zi = 1:size(Z, 1)
    plot3(X(zi, :), Y(zi, :), Z(zi, :), 'k', 'LineWidth', 0.5);
end
% 计算网格中心点坐标
center_Y = Y(1:end-1, 1:end-1) + resolution/2;
center_Z = Z(1:end-1, 1:end-1) + resolution/2;
center_X = (xMax+deviation) * ones(size(center_Y));
% 输出网格中心点坐标
[num_rows, num_cols] = size(center_Y);
for i = 1:num_rows
    for j = 1:num_cols
        re_PP_YZ_Xmax = [re_PP_YZ_Xmax;center_X(i, j), center_Y(i, j), center_Z(i, j)];
    end
end
PP_YZ_Xmax = re_PP_YZ_Xmax;

%% ---------------------------------------------在yz轴平面的映射---x是xMin
% 定义网格的范围和分辨率
y_min = yMin;
y_max = yMax;
z_min = zMin;
z_max = zMax;
resolution = interval; % 网格线的间隔

% 使用 meshgrid 生成 X 和 Z 的坐标矩阵
[Y, Z] = meshgrid(y_min:resolution:y_max, z_min:resolution:z_max);

% 创建一个常数值的 Y 矩阵，表示平面的高度
X = (xMin-deviation) * ones(size(Y));

% 使用 plot3 绘制网格线
% figure;
hold on;
% 绘制 Y 方向上的网格线（在 X = xMin 平面上）
for yi = 1:size(Y, 2)
    plot3(X(:, yi), Y(:, yi), Z(:, yi), 'k', 'LineWidth', 0.5);
end
% 绘制 Z 方向上的网格线（在 X = xMin 平面上）
for zi = 1:size(Z, 1)
    plot3(X(zi, :), Y(zi, :), Z(zi, :), 'k', 'LineWidth', 0.5);
end
% 计算网格中心点坐标
center_Y = Y(1:end-1, 1:end-1) + resolution/2;
center_Z = Z(1:end-1, 1:end-1) + resolution/2;
center_X = (xMin-deviation) * ones(size(center_Y));
% 输出网格中心点坐标
[num_rows, num_cols] = size(center_Y);
for i = 1:num_rows
    for j = 1:num_cols
        re_PP_YZ_Xmin = [re_PP_YZ_Xmin;center_X(i, j), center_Y(i, j), center_Z(i, j)];
    end
end
PP_YZ_Xmin = re_PP_YZ_Xmin;

xlabel('X');
ylabel('Y');
zlabel('Z');
title('Grid Representation of Plane Z = 600');
grid on; % 打开坐标轴的网格线（注意这与我们要表示的平面网格线不同）
view(3); % 设置视角以便更好地查看三维图形
axis equal; % 确保 X、Y、Z 轴的比例相等


end