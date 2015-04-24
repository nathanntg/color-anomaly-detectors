function im_result = pcad(img)
%PCAD Perform the PCAD algorithm on img.

height = size(img, 1);
width = size(img, 2);

cb = @(block) pcad_block(block, 50);
r = blockproc(img, [15 15], cb, 'PadPartialBlocks', true, 'PadMethod', 'symmetric');
    
% MAX
im_result = r(1:height, 1:width);

end
