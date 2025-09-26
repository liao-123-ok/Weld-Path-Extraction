function distances = calculateParallelPlaneDistances(planeA, parallelPlanes, tol)
    % 输入：
    % planeA: 参考平面 [a, b, c, d_A]
    % parallelPlanes: 其他平行平面矩阵，每行是 [a_i, b_i, c_i, d_i]
    % tol: 容差（默认 1e-6）
    % 输出：
    % distances: 各平面到 planeA 的距离
    
    if nargin < 3
        tol = 1e-6; % 默认容差
    end
    
    % 提取参考平面的法向量和常数项
    nA = planeA(1:3);
    d_A = planeA(4);
    norm_nA = norm(nA);
    
    % 初始化距离数组
    numPlanes = size(parallelPlanes, 1);
    distances = zeros(numPlanes, 1);
    
    for i = 1:numPlanes
        ni = parallelPlanes(i, 1:3);
        di = parallelPlanes(i, 4);
        
        % 检查法向量是否平行（允许方向相反）
        cross_norm = norm(cross(nA, ni));
        if isequal(nA, ni)
            distances(i) = -1;
            continue
        end
        
        % 统一法向量方向（确保 ni 与 nA 同向）
        lambda = dot(ni, nA) / (norm_nA^2); % 计算比例因子 λ
        if lambda < -tol % 法向量相反
            ni = -ni;
            di = -di;
            lambda = -lambda;
        elseif abs(lambda) < tol % 零向量（非法输入）
            error('平面 %d 的法向量为零向量！', i);
        end
        
        % 计算距离

        distances(i) = abs(di - lambda * d_A) / (abs(lambda) * norm_nA);
    end
end