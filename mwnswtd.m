function im_result = mwnswtd(img)
%MWNSWTD Perform the MW-NSWTD algorithm on img.
  
im_result = blockproc(img, [1 1], @mwnswtd_block, 'BorderSize', [5 5], 'TrimBorder', false, 'UseParallel', true);
end

