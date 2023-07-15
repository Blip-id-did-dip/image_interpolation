function [curve, true_length] = generate_curve(mask)
%GENERATE_CURVE Makes a parametric curve outlining the region designated
%by mask
%   The Parametric curve consists of a list of ordered points along the
%   curve.

MASK_HIGH = 1;

% Note the parity of directions is important for determining the true
% length of the curve
directions = [-1, -1; 0,-1; 1,-1; 1,0; 1,1; 0,1; -1, 1; -1, 0];

% DIRECTION LIST

%   7   6   5
%   8   +   4
%   1   2   3

mask_height = size(mask,1);
mask_width = size(mask,2);

start_x = 0;
start_y =0;

for xind = 1:mask_height
    for yind = 1:mask_width
        if (mask(xind,yind) == MASK_HIGH)
            start_x = xind;
            start_y = yind;
            break;
        end
    end
    if (start_x ~= 0) 
        break; 
    end
end

curve = zeros(2*(mask_width + mask_height), 2);
curve(1,:)= [start_x,start_y];
curve_ind = 2;

true_length = zeros(2*(mask_width + mask_height), 1);
true_length(1) = 1;

current_direction = 1;
current_x = start_x;
current_y = start_y;

for dir_ind = 0:7
    inspect_x = current_x + directions(current_direction, 1);
    inspect_y = current_y + directions(current_direction, 2);

    if (mask(inspect_x,inspect_y)== MASK_HIGH)
        curve(curve_ind,:) = [inspect_x,inspect_y];

        % for diagonal directions, sqrt2 will be added to the true length
        % and for orthoganal directions, 1 will be added to the true
        % length.
        true_length(curve_ind) = true_length(curve_ind-1) + (sqrt(2) - 1) * mod(current_direction,2) + 1;

        current_x = inspect_x;
        current_y = inspect_y;
        current_direction = mod(current_direction+4,8)+1;
        curve_ind = curve_ind +1; 
        break;
    end

    current_direction = mod(current_direction,8) + 1;
end


while (current_y ~= start_y || current_x ~= start_x)

    for dir_ind = 0:7
        inspect_x = current_x + directions(current_direction, 1);
        inspect_y = current_y + directions(current_direction, 2);

        if (mask(inspect_x,inspect_y)== MASK_HIGH)
            curve(curve_ind,:) = [inspect_x,inspect_y];

            % for diagonal directions, sqrt2 will be added to the true length
            % and for orthoganal directions, 1 will be added to the true
            % length.
            true_length(curve_ind) = true_length(curve_ind-1) + (sqrt(2) - 1) * mod(current_direction,2) + 1;

            current_x = inspect_x;
            current_y = inspect_y;
            current_direction = mod(current_direction+4,8)+1;
            curve_ind = curve_ind +1;
            break;
        end

        current_direction = mod(current_direction,8) + 1;
    end

end

curve = curve(1:curve_ind-2,:);
true_length = true_length(1:curve_ind-2);



end