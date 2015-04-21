function im_result = rxl(img)
%PCAG Perform the PCAG algorithm on img.

im_result = blockproc(img, [1 1], @rxl_block, 'BorderSize', [25 25], 'TrimBorder', false, 'PadPartialBlocks', true, 'PadMethod', 'symmetric');

end

