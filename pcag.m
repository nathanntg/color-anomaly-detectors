function im_result = pcag(img, sz)
%PCAG Perform the PCAG algorithm on img.
  
if nargin < 2
    sz = 5;
end

im_result = blockproc(img, [sz sz], @pcag_block);

end

