%{
Function: judge_two_line_segment_intersection
Description: 判断两段三维线段是否相交(共线且有交集也认为是相交)
Input: 三维线段lineSegmentAB(包含起点与终点坐标), 三维线段lineSegmentCD(包含起点与终点坐标), 容差tolerance
Output: 状态sta(1表示两段三维线段相交，0表示两段三维线段不相交)
Author: Marc Pony(marc_pony@163.com)
%}
function sta = judge_two_line_segment_intersection(lineSegmentAB, lineSegmentCD, tolerance)
x1 = lineSegmentAB.startPoint(1);
y1 = lineSegmentAB.startPoint(2);
z1 = lineSegmentAB.startPoint(3);
x2 = lineSegmentAB.endPoint(1);
y2 = lineSegmentAB.endPoint(2);
z2 = lineSegmentAB.endPoint(3);

x3 = lineSegmentCD.startPoint(1);
y3 = lineSegmentCD.startPoint(2);
z3 = lineSegmentCD.startPoint(3);
x4 = lineSegmentCD.endPoint(1);
y4 = lineSegmentCD.endPoint(2);
z4 = lineSegmentCD.endPoint(3);

a11 = x2 - x1;
a12 = x3 - x4;
b1 = x3 - x1;

a21 = y2 - y1;
a22 = y3 - y4;
b2 = y3 - y1;

a31 = z2 - z1;
a32 = z3 - z4;
b3 = z3 - z1;

A11 = a11^2 + a21^2 + a31^2;
A12 = a11 * a12 + a21 * a22 + a31 * a32;
A21 = A12;
A22 = a12^2 + a22^2 + a32^2;
B1 = a11 * b1 + a21 * b2 + a31 * b3;
B2 = a12 * b1 + a22 * b2 + a32 * b3;

EPS = 1.0e-10;
sta = 0;
temp = A11 * A22 - A12 * A21;
if abs(temp) < EPS  %平行或共线
    
    %判断点C是否在线段AB上
    sta = judge_point_on_line_segment(lineSegmentAB, lineSegmentCD.startPoint, tolerance);
    if sta == 1
        disp('共线且有交集')
        return;
    end
    
    %判断点D是否在线段AB上
    sta = judge_point_on_line_segment(lineSegmentAB, lineSegmentCD.endPoint, tolerance);
    if sta == 1
        disp('共线且有交集')
        return;
    end
    
    %判断点A是否在线段CD上
    sta = judge_point_on_line_segment(lineSegmentCD, lineSegmentAB.startPoint, tolerance);
    if sta == 1
        disp('共线且有交集')
        return;
    end
    
    %判断点B是否在线段CD上
    sta = judge_point_on_line_segment(lineSegmentCD, lineSegmentAB.endPoint, tolerance);
    if sta == 1
        disp('共线且有交集')
        return;
    end
else    %异面或相交
    t = [-(A12 * B2 - A22 * B1) / temp, (A11 * B2 - A21 * B1) / temp];
    if (t(1) >= 0 - EPS && t(1) <= 1.0 + EPS) && (t(2) >= 0 - EPS && t(2) <= 1.0 + EPS)
        if abs( (x1 + (x2 - x1) * t(1)) - (x3 + (x4 - x3) * t(2)) ) < tolerance ...
                && abs( (y1 + (y2 - y1) * t(1)) - (y3 + (y4 - y3) * t(2)) ) < tolerance ...
                && abs( (z1 + (z2 - z1) * t(1)) - (z3 + (z4 - z3) * t(2)) ) < tolerance
            sta = 1;
        end
    end
end

end