function im_result = pcag(img)
%PCAG Perform the PCAG algorithm on img.

im_result = blockproc(img, [15 15], @pcag_block);

end

