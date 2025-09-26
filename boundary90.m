function [outputArg1] = boundary90(triangular_patch,triangular_norm,min_angle)
%找到含90相交面夹角的边界
%   此处显示详细说明
boundary = [];
min_angle = min_angle;
for i = 1:length(triangular_patch)
    rows_with_l1 = any(triangular_patch == triangular_patch(i,1), 2) & any(triangular_patch == triangular_patch(i,2), 2);
    rows_with_l2 = any(triangular_patch == triangular_patch(i,2), 2) & any(triangular_patch == triangular_patch(i,3), 2);
    rows_with_l3 = any(triangular_patch == triangular_patch(i,3), 2) & any(triangular_patch == triangular_patch(i,1), 2);
    %第一条边的相邻面的夹角
    norm_l1 = triangular_norm(rows_with_l1,:);
    dot_product_l1 = dot(norm_l1(1,:), norm_l1(2,:));
    norm_l1_n1 = norm(norm_l1(1,:));
    norm_l1_n2 = norm(norm_l1(2,:));
    cos_theta_l1 = dot_product_l1 / (norm_l1_n1 * norm_l1_n2);
    theta_l1 = acos(cos_theta_l1);
    theta_degrees_1 = rad2deg(theta_l1);
    %第二条边的相邻面的夹角
    norm_l2 = triangular_norm(rows_with_l2,:);
    dot_product_l2 = dot(norm_l2(1,:), norm_l2(2,:));
    norm_l2_n1 = norm(norm_l2(1,:));
    norm_l2_n2 = norm(norm_l2(2,:));
    cos_theta_l2 = dot_product_l2 / (norm_l2_n1 * norm_l2_n2);
    theta_l2 = acos(cos_theta_l2);
    theta_degrees_2 = rad2deg(theta_l2);
    %第三条边的相邻面的夹角
    norm_l3 = triangular_norm(rows_with_l3,:);
    dot_product_l3 = dot(norm_l3(1,:), norm_l3(2,:));
    norm_l3_n1 = norm(norm_l3(1,:));
    norm_l3_n2 = norm(norm_l3(2,:));
    cos_theta_l3 = dot_product_l3 / (norm_l3_n1 * norm_l3_n2);
    theta_l3 = acos(cos_theta_l3);
    theta_degrees_3 = rad2deg(theta_l3);
    if (theta_degrees_1 <= 90 && theta_degrees_1>=min_angle)
        boundary = [boundary;triangular_patch(i,1),triangular_patch(i,2)];
    end
    if (theta_degrees_2 <= 90 && theta_degrees_2>=min_angle)
        boundary = [boundary;triangular_patch(i,2),triangular_patch(i,3)];
    end
    if (theta_degrees_3 <= 90 && theta_degrees_3>=min_angle)
        boundary = [boundary;triangular_patch(i,3),triangular_patch(i,1)];
    end
end
outputArg1 = boundary;
end