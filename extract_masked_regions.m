function img_regions = extract_masked_regions(img, mask, threshold)
%EXTRACT_MASKED_REGIONS Extract channels from image where mask >= threhsold

l = mask >= threshold;

% duplicate mask for all channels
fl = l;
while size(fl, 3) < size(img, 3)
    fl = cat(3, fl, l);
end

img_regions = zeros(size(img), 'like', img);
img_regions(fl) = img(fl);

end
