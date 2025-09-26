function [pos] = Clicked_Point(fig)
%按E继续循环按Q退出循环
%   此处显示详细说明


function output_txt = getClickedPoint(~,event_obj)
pos = get(event_obj,'Position');
output_txt = {['X: ',num2str(pos(1),4)],['Y: ',num2str(pos(2),4)]};
if length(pos) > 2
    output_txt{end+1} = ['Z: ',num2str(pos(3),4)];
end
assignin('base','clicked_point',pos)
end
dcm_obj = datacursormode(fig);
set(dcm_obj,'SnapToDataVertex','off','Enable','on','UpdateFcn',@getClickedPoint)
%% ---------------------------------------------------------------------------

disp('点击一个点,按E获取下一个点');
while true
    userInput = input('', 's');
    if strcmpi(userInput, 'E')
        break; % 退出循环
    end
    pause(0.1); 
end
%% ---------------------------------------------------------------
% 获取点
add_point = [];
while true
    disp('点击一个点');
    add_point = [add_point;clicked_point];
    set(dcm_obj,'SnapToDataVertex','off','Enable','on','UpdateFcn',@getClickedPoint)
    disp('请按下 "Q" 退出或按"E"继续');
    userInput = input('', 's');
    if strcmpi(userInput, 'Q')
        break; % 退出循环
    end
end

for i = 1:length(add_point)
    P1 = add_point(i,:);
    P2 = add_point(i+1,:);
    hold on
    plot3([P1(1), P2(1)], [P1(2), P2(2)], [P1(3), P2(3)], 'r-', 'LineWidth', 2);
end
end