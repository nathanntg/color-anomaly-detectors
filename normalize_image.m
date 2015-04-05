function im_norm = normalize_image(im)
%NORMALIZE_IMAGE Return image in double format with no alpha channel.

% normalize type
if isa(im, 'uint8')
    im_norm = double(im) / (256 - 1);
elseif isa(im, 'uint16')
    im_norm = double(im) / (256 * 256 - 1);
else
    im_norm = im;
end

% remove alpha channel
if 3 == ndims(im_norm) && 4 == size(im_norm, 3)
    im_norm = im_norm(:, :, 1:3);
end

end
