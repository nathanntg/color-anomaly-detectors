function im_result = nswtd(img)
%NSWTD Perform the NSWTD algorithm on img.
  
im_result = blockproc(img, [1 1], @nswtd_block, 'BorderSize', [5 5], 'TrimBorder', false);
end

