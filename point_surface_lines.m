function [outputArg1] = point_surface_lines(inputArg1,inputArg2,inputArg3)
%直线与平面的相交
%   此处显示详细说明
% 线段的起始点与终止点
P0 = inputArg1;
P1 = inputArg2;
Plane_coefficient = inputArg3;
% 线段向量
norm = P1-P0;
norm_p = [Plane_coefficient(1),Plane_coefficient(2),Plane_coefficient(3)];
% 计算向量的点积
dot_product = dot(norm, norm_p);
% 计算向量的模长
norm_a = norm(norm);
norm_b = norm(norm_p);
cos_theta = dot_product / (norm_a * norm_b);
theta_rad = acos(cos_theta);
theta_deg = rad2deg(theta_rad);
fprintf('两个向量之间的夹角为：%.2f 度\n', theta_deg);

coeff_t = Plane_coefficient(1)*norm(1) + Plane_coefficient(2)*norm(2) + Plane_coefficient(3)*norm(3);
const_term = Plane_coefficient(1)*P0(1) + Plane_coefficient(2)*P0(2) + Plane_coefficient(3)*P0(3) + Plane_coefficient(4);
if coeff_t ~= 0
    t = -const_term / coeff_t;
    % 计算交点 P
    P = P0 + t * norm;
    % 显示交点
    disp('交点 P:');
    disp(P);
else
    disp('直线要么完全在平面上，要么与平面平行，没有唯一交点。');
    P=[];
end

outputArg1 = P;
end