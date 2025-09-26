%{
Function: judge_point_on_line_segment
Description: 判断三维空间任意一点是否在三维线段上
Input: 三维线段lineSegment(包含起点与终点坐标), 三维空间任意一点point, 容差tolerance
Output: 状态sta(1表示点在线段上，0表示不在线段上)
Author: Marc Pony(marc_pony@163.com)
%}
function sta = judge_point_on_line_segment(lineSegment, point, tolerance)
%判断三维空间任意一点是否在三维线段上
x1 = lineSegment.startPoint(1);
y1 = lineSegment.startPoint(2);
z1 = lineSegment.startPoint(3);

x2 = lineSegment.endPoint(1);
y2 = lineSegment.endPoint(2);
z2 = lineSegment.endPoint(3);

v1 = [x1 - point(1); y1 - point(2); z1 - point(3)];
v2 = [x2 - point(1); y2 - point(2); z2 - point(3)];
normV1 = norm(v1, 2);
normV2 = norm(v2, 2);
EPS = 1.0e-8;
sta = 0;
if normV1 < tolerance || normV2 < tolerance
    sta = 1;
else
    cosTheta = dot(v1, v2) / normV1 / normV2;
    if abs(cosTheta + 1.0) < EPS   %两向量夹角为180度
        sta = 1;
    end
end

end