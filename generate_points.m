function [points] = generate_points(mask)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
MASK_HIGH = 1;

num_points = sum(sum(mask));

points = zeros(num_points,2);

mask_height = size(mask,1);
mask_width = size(mask,2);

point_index = 1;

for xind = 1:mask_height
    for yind = 1:mask_width
        if(mask(xind,yind) == MASK_HIGH)
            points(point_index,:) = [xind,yind];
            point_index= point_index + 1;
        end
    end
end


end