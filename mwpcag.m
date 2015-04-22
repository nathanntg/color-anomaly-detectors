function im_result = mwpcag(img)
%MWPCAG Perform the MW-PCAG algorithm on img.

height = size(img, 1);
width = size(img, 2);

im_result = zeros(height, width);
for sz = 9:2:15
    % run MW-PCAG
    cb = @(block) mwpcag_block(block, floor((sz-2)^2*0.1), floor(sz*sz*0.45));
    r = blockproc(img, [sz sz], cb, 'PadPartialBlocks', true, 'PadMethod', 'symmetric');
    
    % MAX
    im_result = max(im_result, r(1:height, 1:width));
end

end
