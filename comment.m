%% Load mask and curve using old files and then redo interpolation with new formula
% find the point on the curve closest too and the distance to that point

first_image = imread("images/FrogA.png");
first_mask_image =   imread("images/FrogA_mask.png");

% second_image = first_image;
% second_mask_image = first_mask_image;
second_image = imread("images/shuttle.png");
second_mask_image = imread("images/shuttle_mask.png");

first_mask = generate_mask(first_mask_image);

second_mask = generate_mask(second_mask_image);

[first_curve, first_length] = generate_curve(first_mask);
first_points = generate_points(first_mask);

[A_t_params, A_p_dist] = dsearchn(first_curve, delaunayn(first_curve), first_points);

A_max_p_dist = ones(size(first_curve,1),1);
for index =1:size(A_t_params,1)
    if(A_p_dist(A_t_params(index)) > A_max_p_dist(A_t_params(index)))
         A_max_p_dist(A_t_params(index)) = A_p_dist(A_t_params(index));
    end
end

[second_curve, second_length] = generate_curve(second_mask);
second_points = generate_points(second_mask);

[B_t_params, B_p_dist] = dsearchn(second_curve, delaunayn(second_curve), second_points);
B_max_p_dist = ones(size(second_curve,1),1);
for index =1:size(B_t_params,1)
    if(B_p_dist(B_t_params(index)) > B_max_p_dist(B_t_params(index)))
         B_max_p_dist(B_t_params(index)) = B_p_dist(B_t_params(index));
    end
end

multiplier = first_length(end) / second_length(end);

new_image = zeros(size(second_image),'uint8');

B2A_point_index = dsearchn([first_length(A_t_params) * multiplier, A_p_dist./A_max_p_dist(A_t_params)*20], delaunayn([first_length(A_t_params)*multiplier, A_p_dist./A_max_p_dist(A_t_params)*20]), [second_length(B_t_params), B_p_dist./B_max_p_dist(B_t_params)*20]);

mask_index = 1;

for indx = 1:size(new_image,1)
    for indy= 1:size(new_image,2)
        
        if (second_mask_image(indx,indy)==0)
            new_image(indx,indy,:) = second_image(indx,indy,:);
        else
            new_image(indx,indy,:) = first_image(first_points(B2A_point_index(mask_index),1),first_points(B2A_point_index(mask_index),2),:);
            mask_index = mask_index + 1;
        end

    end
end

Knew_image = zeros(size(first_image),'uint8');

A2B_point_index = dsearchn([second_length(B_t_params), B_p_dist./B_max_p_dist(B_t_params)*20], delaunayn([second_length(B_t_params), B_p_dist./B_max_p_dist(B_t_params)*20]), [first_length(A_t_params) * multiplier, A_p_dist./A_max_p_dist(A_t_params)*20]);

mask_index = 1;

for indx = 1:size(Knew_image,1)
    for indy= 1:size(Knew_image,2)
        
        if (first_mask_image(indx,indy)==0)
            Knew_image(indx,indy,:) = first_image(indx,indy,:);
        else
            Knew_image(indx,indy,:) = second_image(second_points(A2B_point_index(mask_index),1),second_points(A2B_point_index(mask_index),2),:);
            mask_index = mask_index + 1;
        end

    end
end