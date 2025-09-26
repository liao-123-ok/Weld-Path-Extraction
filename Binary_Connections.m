function [outputArg1] = Binary_Connections(inputArg1)
% 二元连接的节点分段连续函数
% 该里面所有的分段节点出现的个数都是2

Proposed_Weld_Seam = inputArg1;
%% 检测里面的所有节点是否出现两次

% 使用 unique 函数提取唯一元素
Number_values = [];
uniqueElements = unique(Proposed_Weld_Seam);
for i = 1:length(uniqueElements)
    N = uniqueElements(i);
    frequency = length(find(Proposed_Weld_Seam==N));
    Number_values = [Number_values;N,frequency];
end

%% 创建基本的初始启动值
behind = Proposed_Weld_Seam(1,:);
colied = behind;
cell = {};
Proposed_Weld_Seam = Proposed_Weld_Seam(2:end,:);
j = 0;

%% 对初始焊缝轨迹进行二元连接拼接
% 对数组进行是否空数组判断
while ~isempty(Proposed_Weld_Seam)
    % 向后进行拼接
    [rowIndices, colIndices] = find(Proposed_Weld_Seam == behind(2));
    behind = Proposed_Weld_Seam(rowIndices,:);
    if colIndices == 2
        temp = behind(1,1);
        behind(1,1) = behind(1,2);
        behind(1,2) = temp;
    end
    colied = [colied;behind];
    Proposed_Weld_Seam = [Proposed_Weld_Seam(1:rowIndices-1, :); Proposed_Weld_Seam(rowIndices+1:end, :)];
    if colied(1,1)==colied(end,2)
        j = j+1;
        cell{j,1} = colied;
        if isempty(Proposed_Weld_Seam)
            break
        end
        behind = Proposed_Weld_Seam(1,:);
        colied = behind;
        Proposed_Weld_Seam = Proposed_Weld_Seam(2:end,:);
    end
end
outputArg1 = cell;
end