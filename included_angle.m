function [included_angle] = included_angle(plane_norm1,plane_norm2)
% 输入两个平面的法向量，输出平面夹角
%   此处显示详细说明
% 计算点积
n1 = plane_norm1;
n2 = plane_norm2;
dot_product = dot(n1, n2);
 
% 计算法向量的模
norm_n1 = norm(n1);
norm_n2 = norm(n2);
 
% 计算夹角的余弦值
cos_theta = dot_product / (norm_n1 * norm_n2);
 
% 计算夹角（弧度）
theta_rad = acos(cos_theta);
 
% 将夹角转换为角度（可选）
included_angle = rad2deg(theta_rad);
end