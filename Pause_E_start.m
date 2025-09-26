function Pause_E_start
% 无限循环，直到用户按下 'E' 键
while true
    % 显示提示信息（可选）
    disp('请按下 "E" 键继续...');
    
    % 读取用户输入（不带回显）
    userInput = input('', 's');
    
    % 检查输入是否为 'E'（不区分大小写）
    if strcmpi(userInput, 'E')
        break; % 退出循环
    end
    
    % 可选：为了避免过于频繁的输入提示，可以添加一个小的暂停
    pause(0.1); 
end

% 继续执行脚本的其余部分
% disp('程序已继续执行。');
end