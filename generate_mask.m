function [mask] = generate_mask(mask_image)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

mask = zeros(size(mask_image,1)+2,size(mask_image,2)+2);

mask(2:size(mask_image,1)+1, 2:size(mask_image,2)+1)= mask_image;

end