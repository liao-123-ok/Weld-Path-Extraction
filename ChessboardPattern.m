function [CP_XY_Zmax,CP_XY_Zmin,CP_XZ_Ymax,CP_XZ_Ymin,CP_YZ_Xmax,CP_YZ_Xmin] = ChessboardPattern(inputArg1,inputArg2,inputArg3)
%棋盘格分割演示
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
re_CP_XY_Zmax = [];
re_CP_XY_Zmin = [];
re_CP_XZ_Ymax = [];
re_CP_XZ_Ymin = [];
re_CP_YZ_Xmax = [];
re_CP_YZ_Xmin = [];
%% ---------------------------------------------在xy轴平面的映射---z是zMax
% 定义棋盘的大小
x_min = xMin;
x_max = xMax;
y_min = yMin;
y_max = yMax;
resolution = interval; % 网格的间隔
% 使用 meshgrid 生成 X 和 Y 的坐标矩阵
[X, Y] = meshgrid(x_min:resolution:x_max, y_min:resolution:y_max);

% 创建一个与 X 和 Y 相同大小的零矩阵 Z，表示棋盘格位于 Z = 0（稍后会调整）
% Z = (zMax+deviation)*zeros(size(X));

% 使用 fill3 绘制每个棋盘格
% 注意：这里我们为每个格子创建一个四边形，并将其 Z 值设置为 600
% figure;
hold on; % 保持当前图形，以便在同一个图上绘制多个格子
for i = 1:size(X,1)-1
    for j = 1:size(Y,2)-1
        % 计算当前格子的四个顶点的坐标
        x = [X(i,j), X(i,j+1), X(i+1,j+1), X(i+1,j)];
        y = [Y(i,j), Y(i,j+1), Y(i+1,j+1), Y(i+1,j)];
        z = (zMax+deviation) * ones(1, 4); % 所有顶点的 Z 值都是 600
        
        % 根据当前格子的颜色选择填充颜色
        % 这里我们简单地使用黑白交替的模式
        if mod(i+j, 2) == 0
            color = [1 1 1]; % 白色
        else
            color = [0 0 0]; % 黑色
            x1 = x';
            y1 = y';
            z1 = z';
            points = [x1,y1,z1];
            center = mean(points);
            re_CP_XY_Zmax = [re_CP_XY_Zmax;center(1),center(2),center(3)];
            CP_XY_Zmax = re_CP_XY_Zmax;
        end
        % 使用 fill3 绘制当前格子
        fill3(x, y, z, color);
    end
end
hold off; % 释放当前图形

% 设置图形的视角和标签（与之前相同）
view(3);
xlabel('X');
ylabel('Y');
zlabel('Z');
title('10x10 Chessboard Grid at Z = 600 (Filled)');
axis equal;
grid on; % 可以选择打开或关闭网格线，因为棋盘格本身就有网格线
%% ---------------------------------------------在xy轴平面的映射---z是zMin
% 定义棋盘的大小
x_min = xMin;
x_max = xMax;
y_min = yMin;
y_max = yMax;
resolution = interval; % 网格的间隔
% 使用 meshgrid 生成 X 和 Y 的坐标矩阵
[X, Y] = meshgrid(x_min:resolution:x_max, y_min:resolution:y_max);

% 创建一个与 X 和 Y 相同大小的零矩阵 Z，表示棋盘格位于 Z = 0（稍后会调整）
% Z = (zMax+deviation)*zeros(size(X));

% 使用 fill3 绘制每个棋盘格
% 注意：这里我们为每个格子创建一个四边形，并将其 Z 值设置为 600
% figure;
hold on; % 保持当前图形，以便在同一个图上绘制多个格子
for i = 1:size(X,1)-1
    for j = 1:size(Y,2)-1
        % 计算当前格子的四个顶点的坐标
        x = [X(i,j), X(i,j+1), X(i+1,j+1), X(i+1,j)];
        y = [Y(i,j), Y(i,j+1), Y(i+1,j+1), Y(i+1,j)];
        z = (zMin-deviation) * ones(1, 4); % 所有顶点的 Z 值都是 600
        
        % 根据当前格子的颜色选择填充颜色
        % 这里我们简单地使用黑白交替的模式
        if mod(i+j, 2) == 0
            color = [1 1 1]; % 白色
        else
            color = [0 0 0]; % 黑色
            x1 = x';
            y1 = y';
            z1 = z';
            points = [x1,y1,z1];
            center = mean(points);
            re_CP_XY_Zmin = [re_CP_XY_Zmin;center(1),center(2),center(3)];
            CP_XY_Zmin = re_CP_XY_Zmin;
        end
        % 使用 fill3 绘制当前格子
        fill3(x, y, z, color);
    end
end
hold off; % 释放当前图形

% 设置图形的视角和标签（与之前相同）
view(3);
xlabel('X');
ylabel('Y');
zlabel('Z');
title('10x10 Chessboard Grid at Z = 600 (Filled)');
axis equal;
grid on; % 可以选择打开或关闭网格线，因为棋盘格本身就有网格线
%% ---------------------------------------------在xz轴平面的映射---y是yMax
% 定义棋盘的大小
x_min = xMin;
x_max = xMax;
z_min = zMin;
z_max = zMax;
resolution = interval; % 网格的间隔
% 使用 meshgrid 生成 X 和 Y 的坐标矩阵
[X, Z] = meshgrid(x_min:resolution:x_max, z_min:resolution:z_max);

% 创建一个与 X 和 Y 相同大小的零矩阵 Z，表示棋盘格位于 Z = 0（稍后会调整）
% Z = (zMax+deviation)*zeros(size(X));

% 使用 fill3 绘制每个棋盘格
% 注意：这里我们为每个格子创建一个四边形，并将其 Z 值设置为 600
% figure;
hold on; % 保持当前图形，以便在同一个图上绘制多个格子
for i = 1:size(X,1)-1
    for j = 1:size(Z,2)-1
        % 计算当前格子的四个顶点的坐标
        x = [X(i,j), X(i,j+1), X(i+1,j+1), X(i+1,j)];
        z = [Z(i,j), Z(i,j+1), Z(i+1,j+1), Z(i+1,j)];
        y = (yMax+deviation) * ones(1, 4); % 所有顶点的 Z 值都是 600
        
        % 根据当前格子的颜色选择填充颜色
        % 这里我们简单地使用黑白交替的模式
        if mod(i+j, 2) == 0
            color = [1 1 1]; % 白色
        else
            color = [0 0 0]; % 黑色
            x1 = x';
            y1 = y';
            z1 = z';
            points = [x1,y1,z1];
            center = mean(points);
            re_CP_XZ_Ymax = [re_CP_XZ_Ymax;center(1),center(2),center(3)];
            CP_XZ_Ymax = re_CP_XZ_Ymax;
        end
        
        % 使用 fill3 绘制当前格子
        fill3(x, y, z, color);
    end
end
hold off; % 释放当前图形

% 设置图形的视角和标签（与之前相同）
view(3);
xlabel('X');
ylabel('Y');
zlabel('Z');
title('10x10 Chessboard Grid at Z = 600 (Filled)');
axis equal;
grid on; % 可以选择打开或关闭网格线，因为棋盘格本身就有网格线
%% ---------------------------------------------在xz轴平面的映射---y是yMin
% 定义棋盘的大小
x_min = xMin;
x_max = xMax;
z_min = zMin;
z_max = zMax;
resolution = interval; % 网格的间隔
% 使用 meshgrid 生成 X 和 Y 的坐标矩阵
[X, Z] = meshgrid(x_min:resolution:x_max, z_min:resolution:z_max);

% 创建一个与 X 和 Y 相同大小的零矩阵 Z，表示棋盘格位于 Z = 0（稍后会调整）
% Z = (zMax+deviation)*zeros(size(X));

% 使用 fill3 绘制每个棋盘格
% 注意：这里我们为每个格子创建一个四边形，并将其 Z 值设置为 600
% figure;
hold on; % 保持当前图形，以便在同一个图上绘制多个格子
for i = 1:size(X,1)-1
    for j = 1:size(Z,2)-1
        % 计算当前格子的四个顶点的坐标
        x = [X(i,j), X(i,j+1), X(i+1,j+1), X(i+1,j)];
        z = [Z(i,j), Z(i,j+1), Z(i+1,j+1), Z(i+1,j)];
        y = (yMin-deviation) * ones(1, 4); % 所有顶点的 Z 值都是 600
        
        % 根据当前格子的颜色选择填充颜色
        % 这里我们简单地使用黑白交替的模式
        if mod(i+j, 2) == 0
            color = [1 1 1]; % 白色
        else
            color = [0 0 0]; % 黑色
            x1 = x';
            y1 = y';
            z1 = z';
            points = [x1,y1,z1];
            center = mean(points);
            re_CP_XZ_Ymin = [re_CP_XZ_Ymin;center(1),center(2),center(3)];
            CP_XZ_Ymin = re_CP_XZ_Ymin;
        end
        
        % 使用 fill3 绘制当前格子
        fill3(x, y, z, color);
    end
end
hold off; % 释放当前图形

% 设置图形的视角和标签（与之前相同）
view(3);
xlabel('X');
ylabel('Y');
zlabel('Z');
title('10x10 Chessboard Grid at Z = 600 (Filled)');
axis equal;
grid on; % 可以选择打开或关闭网格线，因为棋盘格本身就有网格线
%% ---------------------------------------------在yz轴平面的映射---x是xMax
% 定义棋盘的大小
y_min = yMin;
y_max = yMax;
z_min = zMin;
z_max = zMax;
resolution = interval; % 网格的间隔
% 使用 meshgrid 生成 X 和 Y 的坐标矩阵
[Y, Z] = meshgrid(y_min:resolution:y_max, z_min:resolution:z_max);

% 创建一个与 X 和 Y 相同大小的零矩阵 Z，表示棋盘格位于 Z = 0（稍后会调整）
% Z = (zMax+deviation)*zeros(size(X));

% 使用 fill3 绘制每个棋盘格
% 注意：这里我们为每个格子创建一个四边形，并将其 Z 值设置为 600
% figure;
hold on; % 保持当前图形，以便在同一个图上绘制多个格子
for i = 1:size(Y,1)-1
    for j = 1:size(Z,2)-1
        % 计算当前格子的四个顶点的坐标
        y = [Y(i,j), Y(i,j+1), Y(i+1,j+1), Y(i+1,j)];
        z = [Z(i,j), Z(i,j+1), Z(i+1,j+1), Z(i+1,j)];
        x = (xMax+deviation) * ones(1, 4); % 所有顶点的 Z 值都是 600
        
        % 根据当前格子的颜色选择填充颜色
        % 这里我们简单地使用黑白交替的模式
        if mod(i+j, 2) == 0
            color = [1 1 1]; % 白色
        else
            color = [0 0 0]; % 黑色
            x1 = x';
            y1 = y';
            z1 = z';
            points = [x1,y1,z1];
            center = mean(points);
            re_CP_YZ_Xmax = [re_CP_YZ_Xmax;center(1),center(2),center(3)];
            CP_YZ_Xmax = re_CP_YZ_Xmax;
        end
        
        % 使用 fill3 绘制当前格子
        fill3(x, y, z, color);
    end
end
hold off; % 释放当前图形

% 设置图形的视角和标签（与之前相同）
view(3);
xlabel('X');
ylabel('Y');
zlabel('Z');
title('10x10 Chessboard Grid at Z = 600 (Filled)');
axis equal;
grid on; % 可以选择打开或关闭网格线，因为棋盘格本身就有网格线
%% ---------------------------------------------在yz轴平面的映射---x是xMin
% 定义棋盘的大小
y_min = yMin;
y_max = yMax;
z_min = zMin;
z_max = zMax;
resolution = interval; % 网格的间隔
% 使用 meshgrid 生成 X 和 Y 的坐标矩阵
[Y, Z] = meshgrid(y_min:resolution:y_max, z_min:resolution:z_max);

% 创建一个与 X 和 Y 相同大小的零矩阵 Z，表示棋盘格位于 Z = 0（稍后会调整）
% Z = (zMax+deviation)*zeros(size(X));

% 使用 fill3 绘制每个棋盘格
% 注意：这里我们为每个格子创建一个四边形，并将其 Z 值设置为 600
% figure;
hold on; % 保持当前图形，以便在同一个图上绘制多个格子
for i = 1:size(Y,1)-1
    for j = 1:size(Z,2)-1
        % 计算当前格子的四个顶点的坐标
        y = [Y(i,j), Y(i,j+1), Y(i+1,j+1), Y(i+1,j)];
        z = [Z(i,j), Z(i,j+1), Z(i+1,j+1), Z(i+1,j)];
        x = (xMin-deviation) * ones(1, 4); % 所有顶点的 Z 值都是 600
        
        % 根据当前格子的颜色选择填充颜色
        % 这里我们简单地使用黑白交替的模式
        if mod(i+j, 2) == 0
            color = [1 1 1]; % 白色
        else
            color = [0 0 0]; % 黑色
            x1 = x';
            y1 = y';
            z1 = z';
            points = [x1,y1,z1];
            center = mean(points);
            re_CP_YZ_Xmin = [re_CP_YZ_Xmin;center(1),center(2),center(3)];
            CP_YZ_Xmin = re_CP_YZ_Xmin;
        end
        
        % 使用 fill3 绘制当前格子
        fill3(x, y, z, color);
    end
end
hold off; % 释放当前图形

% 设置图形的视角和标签（与之前相同）
view(3);
xlabel('X');
ylabel('Y');
zlabel('Z');
title('10x10 Chessboard Grid at Z = 600 (Filled)');
axis equal;
grid on; % 可以选择打开或关闭网格线，因为棋盘格本身就有网格线

end