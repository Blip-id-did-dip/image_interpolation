%% Load mask and curve using old files and then redo interpolation with new formula
% find the point on the curve closest too and the distance to that point

raw_image = imread("images/frog.jpg");

mask_image =   imread("images/frogmask.png");

mask = zeros(size(mask_image,1)+2,size(mask_image,2)+2);

mask(2:size(mask_image,1)+1, 2:size(mask_image,2)+1)= mask_image;

my_curve = generate_curve(mask);

my_points = generate_points(mask);

[t_params, p_dist] = dsearchn(my_curve, delaunayn(my_curve), my_points);