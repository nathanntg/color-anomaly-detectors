function img_padded = pad_image_symmetric(img, padding)
%PAD_IMAGE_SYMMETRIC Pad img by padding semmetrically filling in new pixels

% constant padding
if all(size(padding) == 1)
    padding = [padding padding padding padding];
end

% expand padding
pad_top = padding(1);
pad_right = padding(1);
pad_bottom = padding(3);
pad_left = padding(4);

% get current dimensions
[height, width, channels] = size(img);

img_padded = zeros(height + pad_top + pad_bottom, width + pad_left + pad_right, channels);
img_padded(pad_top + 1:pad_top + height, pad_left + 1:pad_left + width, :) = img;

% fill in sides
img_padded(1:pad_top, pad_left + 1:pad_left + width, :) = img(pad_top:-1:1, :, :);
img_padded(pad_top + height:end, pad_left + 1:pad_left + width, :) = img(end:-1:end - pad_bottom, :, :);
img_padded(pad_top + 1:pad_top + height, 1:pad_left, :) = img(:, pad_left:-1:1, :);
img_padded(pad_top + 1:pad_top + height, pad_left + width:end, :) = img(:, end:-1:end - pad_right, :);

% fill in corners
img_padded(1:pad_top, 1:pad_left, :) = img(pad_top:-1:1, pad_left:-1:1, :);
img_padded(1:pad_top, pad_left + width:end, :) = img(pad_top:-1:1, end:-1:end - pad_right, :);
img_padded(pad_top + height:end, 1:pad_left, :) = img(end:-1:end - pad_bottom, pad_left:-1:1, :);
img_padded(pad_top + height:end, pad_left + width:end, :) = img(end:-1:end - pad_bottom, end:-1:end - pad_right, :);

end
