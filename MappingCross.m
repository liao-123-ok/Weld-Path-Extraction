function [MC_XY_Zmax,MC_XY_Zmin,MC_XZ_Ymax,MC_XZ_Ymin,MC_YZ_Xmax,MC_YZ_Xmin] = MappingCross(inputArg1,inputArg2,inputArg3)
% 网格线演示
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
re_MC_XY_Zmax = [];
re_MC_XY_Zmin = [];
re_MC_XZ_Ymax = [];
re_MC_XZ_Ymin = [];
re_MC_YZ_Xmax = [];
re_MC_YZ_Xmin = [];
%% ---------------------------------------------在xy轴平面的映射---z是zMax
% 定义网格的范围和分辨率
x_min = xMin;
x_max = xMax;
y_min = yMin;
y_max = yMax;
resolution = interval; % 网格的间隔

% 使用 meshgrid 生成 X 和 Y 的坐标矩阵
[X, Y] = meshgrid(x_min:resolution:x_max, y_min:resolution:y_max);

% 创建一个常数值的 Z 矩阵，表示平面的高度
Z = (zMax+deviation) * ones(size(X));

% 使用 surf 绘制平面，并设置 FaceColor 为 'none' 以显示网格线
% figure;
surf(X, Y, Z, 'FaceColor', 'none', 'EdgeColor', 'black');
hold on;

% 设置图形的视角和轴标签
% view(3);
% xlabel('X');
% ylabel('Y');
% zlabel('Z');
% title('Grid Plane at Z = 600 with Interval Filling Simulation');
% grid on; % 打开坐标轴的网格线（注意这与平面上的网格线不同）
% axis equal; % 确保 X、Y、Z 轴的比例相等

% 在网格线的交点处绘制模拟的间隔填充点（可选）
% 这里我们只在每个网格的中心点绘制一个小正方形作为示例
% 注意：这种方法在分辨率很高时可能不太实用，因为它会绘制很多点
for i = 1:size(X,1)
    for j = 1:size(X,2)
        plot3(X(i,j), Y(i,j), Z(i,j), 'k.', 'MarkerSize', 10); % 使用点来模拟填充 
        re_MC_XY_Zmax = [re_MC_XY_Zmax;X(i,j),Y(i,j),Z(i,j)];
    end
end
MC_XY_Zmax = re_MC_XY_Zmax;
%% ---------------------------------------------在xy轴平面的映射---z是zMin
% 定义网格的范围和分辨率
x_min = xMin;
x_max = xMax;
y_min = yMin;
y_max = yMax;
resolution = interval; % 网格的间隔

% 使用 meshgrid 生成 X 和 Y 的坐标矩阵
[X, Y] = meshgrid(x_min:resolution:x_max, y_min:resolution:y_max);

% 创建一个常数值的 Z 矩阵，表示平面的高度
Z = (zMin-deviation) * ones(size(X));

% 使用 surf 绘制平面，并设置 FaceColor 为 'none' 以显示网格线
% figure;
surf(X, Y, Z, 'FaceColor', 'none', 'EdgeColor', 'black');
hold on;

% 设置图形的视角和轴标签
% view(3);
% xlabel('X');
% ylabel('Y');
% zlabel('Z');
% title('Grid Plane at Z = 600 with Interval Filling Simulation');
% grid on; % 打开坐标轴的网格线（注意这与平面上的网格线不同）
% axis equal; % 确保 X、Y、Z 轴的比例相等

% 在网格线的交点处绘制模拟的间隔填充点（可选）
% 这里我们只在每个网格的中心点绘制一个小正方形作为示例
% 注意：这种方法在分辨率很高时可能不太实用，因为它会绘制很多点
for i = 1:size(X,1)
    for j = 1:size(X,2)
        plot3(X(i,j), Y(i,j), Z(i,j), 'k.', 'MarkerSize', 10); % 使用点来模拟填充
        re_MC_XY_Zmin = [re_MC_XY_Zmin;X(i,j),Y(i,j),Z(i,j)];
    end
end
MC_XY_Zmin = re_MC_XY_Zmin;
%% ---------------------------------------------在xz轴平面的映射---y是yMax
% 定义网格的范围和分辨率
x_min = xMin;
x_max = xMax;
z_min = zMin;
z_max = zMax;
resolution = interval; % 网格的间隔

% 使用 meshgrid 生成 X 和 Y 的坐标矩阵
[X, Z] = meshgrid(x_min:resolution:x_max, z_min:resolution:z_max);

% 创建一个常数值的 Z 矩阵，表示平面的高度
Y = (yMax+deviation) * ones(size(X));

% 使用 surf 绘制平面，并设置 FaceColor 为 'none' 以显示网格线
% figure;
surf(X, Y, Z, 'FaceColor', 'none', 'EdgeColor', 'black');
hold on;

% 设置图形的视角和轴标签
% view(3);
% xlabel('X');
% ylabel('Y');
% zlabel('Z');
% title('Grid Plane at Z = 600 with Interval Filling Simulation');
% grid on; % 打开坐标轴的网格线（注意这与平面上的网格线不同）
% axis equal; % 确保 X、Y、Z 轴的比例相等

% 在网格线的交点处绘制模拟的间隔填充点（可选）
% 这里我们只在每个网格的中心点绘制一个小正方形作为示例
% 注意：这种方法在分辨率很高时可能不太实用，因为它会绘制很多点
for i = 1:size(X,1)
    for j = 1:size(X,2)
        plot3(X(i,j), Y(i,j), Z(i,j), 'k.', 'MarkerSize', 10); % 使用点来模拟填充
        re_MC_XZ_Ymax = [re_MC_XZ_Ymax; X(i,j), Y(i,j), Z(i,j)];
    end
end
MC_XZ_Ymax = re_MC_XZ_Ymax;
%% ---------------------------------------------在xz轴平面的映射---y是yMin
% 定义网格的范围和分辨率
x_min = xMin;
x_max = xMax;
z_min = zMin;
z_max = zMax;
resolution = interval; % 网格的间隔

% 使用 meshgrid 生成 X 和 Y 的坐标矩阵
[X, Z] = meshgrid(x_min:resolution:x_max, z_min:resolution:z_max);

% 创建一个常数值的 Z 矩阵，表示平面的高度
Y = (yMin-deviation) * ones(size(X));

% 使用 surf 绘制平面，并设置 FaceColor 为 'none' 以显示网格线
% figure;
surf(X, Y, Z, 'FaceColor', 'none', 'EdgeColor', 'black');
hold on;

% 设置图形的视角和轴标签
% view(3);
% xlabel('X');
% ylabel('Y');
% zlabel('Z');
% title('Grid Plane at Z = 600 with Interval Filling Simulation');
% grid on; % 打开坐标轴的网格线（注意这与平面上的网格线不同）
% axis equal; % 确保 X、Y、Z 轴的比例相等

% 在网格线的交点处绘制模拟的间隔填充点（可选）
% 这里我们只在每个网格的中心点绘制一个小正方形作为示例
% 注意：这种方法在分辨率很高时可能不太实用，因为它会绘制很多点
for i = 1:size(X,1)
    for j = 1:size(X,2)
        plot3(X(i,j), Y(i,j), Z(i,j), 'k.', 'MarkerSize', 10); % 使用点来模拟填充
        re_MC_XZ_Ymin = [re_MC_XZ_Ymin; X(i,j), Y(i,j), Z(i,j)];
    end
end
MC_XZ_Ymin = re_MC_XZ_Ymin;
%% ---------------------------------------------在yz轴平面的映射---x是xMax
% 定义网格的范围和分辨率
y_min = yMin;
y_max = yMax;
z_min = zMin;
z_max = zMax;
resolution = interval; % 网格的间隔

% 使用 meshgrid 生成 X 和 Y 的坐标矩阵
[Y, Z] = meshgrid(y_min:resolution:y_max, z_min:resolution:z_max);

% 创建一个常数值的 Z 矩阵，表示平面的高度
X = (xMax+deviation) * ones(size(Y));

% 使用 surf 绘制平面，并设置 FaceColor 为 'none' 以显示网格线
% figure;
surf(X, Y, Z, 'FaceColor', 'none', 'EdgeColor', 'black');
hold on;

% 设置图形的视角和轴标签
% view(3);
% xlabel('X');
% ylabel('Y');
% zlabel('Z');
% title('Grid Plane at Z = 600 with Interval Filling Simulation');
% grid on; % 打开坐标轴的网格线（注意这与平面上的网格线不同）
% axis equal; % 确保 X、Y、Z 轴的比例相等

% 在网格线的交点处绘制模拟的间隔填充点（可选）
% 这里我们只在每个网格的中心点绘制一个小正方形作为示例
% 注意：这种方法在分辨率很高时可能不太实用，因为它会绘制很多点
for i = 1:size(Y,1)
    for j = 1:size(Y,2)
        plot3(X(i,j), Y(i,j), Z(i,j), 'k.', 'MarkerSize', 10); % 使用点来模拟填充
        re_MC_YZ_Xmax = [re_MC_YZ_Xmax; X(i,j), Y(i,j), Z(i,j)];
    end
end
MC_YZ_Xmax = re_MC_YZ_Xmax;
%% ---------------------------------------------在yz轴平面的映射---x是xMin
% 定义网格的范围和分辨率
y_min = yMin;
y_max = yMax;
z_min = zMin;
z_max = zMax;
resolution = interval; % 网格的间隔

% 使用 meshgrid 生成 X 和 Y 的坐标矩阵
[Y, Z] = meshgrid(y_min:resolution:y_max, z_min:resolution:z_max);

% 创建一个常数值的 Z 矩阵，表示平面的高度
X = (xMin-deviation) * ones(size(Y));

% 使用 surf 绘制平面，并设置 FaceColor 为 'none' 以显示网格线
% figure;
surf(X, Y, Z, 'FaceColor', 'none', 'EdgeColor', 'black');
hold on;

% 设置图形的视角和轴标签
% view(3);
% xlabel('X');
% ylabel('Y');
% zlabel('Z');
% title('Grid Plane at Z = 600 with Interval Filling Simulation');
% grid on; % 打开坐标轴的网格线（注意这与平面上的网格线不同）
% axis equal; % 确保 X、Y、Z 轴的比例相等

% 在网格线的交点处绘制模拟的间隔填充点（可选）
% 这里我们只在每个网格的中心点绘制一个小正方形作为示例
% 注意：这种方法在分辨率很高时可能不太实用，因为它会绘制很多点
for i = 1:size(Y,1)
    for j = 1:size(Y,2)
        plot3(X(i,j), Y(i,j), Z(i,j), 'k.', 'MarkerSize', 10); % 使用点来模拟填充
        re_MC_YZ_Xmin = [re_MC_YZ_Xmin; X(i,j), Y(i,j), Z(i,j)];
    end
end
MC_YZ_Xmin = re_MC_YZ_Xmin;
end