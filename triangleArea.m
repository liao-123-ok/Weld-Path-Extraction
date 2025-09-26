function area = triangleArea(A, B, C)
    % 输入：
    % A, B, C 是三角形的三个顶点坐标，每个是 1x3 的向量 [x, y, z]
    % 输出：
    % area 是三角形的面积

    % 计算向量 AB 和 AC
    AB = B - A;
    AC = C - A;

    % 计算叉积
    cross_product = cross(AB, AC);

    % 计算叉积的模
    cross_norm = norm(cross_product);

    % 计算面积
    area = 0.5 * cross_norm;
end