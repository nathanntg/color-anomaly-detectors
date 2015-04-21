function img_out = rxl_block(block_struct)
%RXL_BLOCK Perform the local RX algorithm on a single image block.

% image size
%height = size(block_struct.data, 1);
width = size(block_struct.data, 2);
channels = size(block_struct.data, 3);

% get inner and out
guard = 7;
%mask_inner = sq_mask(width, channels, 1);
mask_outer = sq_mask(width, channels, width, guard);

% get reshaped data
%inner = reshape(block_struct.data(mask_inner), [], channels);
inner = reshape(block_struct.data(1 + block_struct.border(1), 1 + block_struct.border(2), :), [], channels);
outer = reshape(block_struct.data(mask_outer), [], channels);

% Separate block into color channels to calculate K matrix
K = cov(outer);

% cneter inner pixel
inner = inner - mean(outer);

img_out = (inner / inv(K)) * inner';

end
