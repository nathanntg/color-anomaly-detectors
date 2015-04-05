function im_result = nswtd(img)
%NSWTD Perform the NSWTD algorithm on img.

% largest window size (must be odd)
w_max_size = 11;

% image information
[height, width, channels] = size(img);

% return image
im_result = zeros(height, width);

% prebuild masks
masks = {};
masks_inv = {};
for w_size = 1:2:(w_max_size - 2)
	masks{end + 1} = reshape(sq_mask(w_max_size, 1, w_size), [], 1);
	masks_inv{end + 1} = ~masks{end};
end
num_masks = length(masks);

% pad image
border = (w_max_size - 1) / 2;
pad_img = pad_image_symmetric(img, border);
for i = 1:width
	for j = 1:height
		d = nan;
		
		% reshape window
		win = reshape(pad_img(j:j + w_max_size - 1, i:i + w_max_size - 1, :), [], channels);
		
		% for each mask
		for k = 1:num_masks
            % inner and outer window mean
            if 1 < k
                iw_mean = mean(win(masks{k}, :), 1);
            else
                iw_mean = win(masks{k}, :);
            end
			ow_mean = mean(win(masks_inv{k}, :), 1);
            
            % OPD
            d = opd(iw_mean, ow_mean);
		end
		
		im_result(j, i) = d;
	end
end

end
