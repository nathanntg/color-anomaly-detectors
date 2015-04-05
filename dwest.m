function im_result = dwest(img)
%DWEST Perform the DWEST algorithm on img.
im_result = blockproc(img, [1 1], @dwest_block, 'BorderSize', [5 5], 'TrimBorder', false, 'PadMethod', 'symmetric', 'UseParallel', true);
end
