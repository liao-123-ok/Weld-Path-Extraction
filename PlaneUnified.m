%% ---(I1)plane_xs平面系数
%% ---(O1)collection_plane_xu联合平面系数
function [outputArg1] = PlaneUnified(inputArg1)
%将在同一平面的三角面片整合在一个平面
%将模型点在平面上
plane_xs = inputArg1;
unique_plane_xs = unique(plane_xs, 'rows');
outputArg1 = unique_plane_xs;
end