function [ intersect ] = Circle_intersect( center1,radius1, center2,radius2)
%CIRCLE_INTERSECT Summary of this function goes here
%   Detailed explanation goes here

intersect = 0;

r = radius1 + radius2;
if norm(center1 - center2) < r
    intersect = 1;
end
end

