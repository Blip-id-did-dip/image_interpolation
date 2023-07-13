%% Load mask and curve using old files and then redo interpolation with new formula
% find the point on the curve closest too and the distance to that point

raw_image = imread("frog.jpg");

mask_image =   imread("frogmask.png");

mask = zeros(size(mask_image,1)+2,size(mask_image,2)+2);

mask(2:size(mask_image,1)+1, 2:size(mask_image,2)+1)= mask_image;

my_curve = generate_curve(mask);