function px = nswtd_block(block_struct)
%NSWTD Perform the nested window anomaly detection algorithm.
% Called for a single block of the iamge.

% square odd dimension
block_size = size(block_struct.data, 1);
channels = size(block_struct.data, 3);
mid_point = (block_size - 1) / 2;
mask = false([block_size block_size channels]);

px = nan;
for iw_size = 1:2:(block_size - 4)
    % update mask
    d = (iw_size - 1) / 2;
    mask(mid_point - d:mid_point + d, mid_point - d:mid_point + d, :) = true([iw_size iw_size channels]);
    
    % extract windows
    iw = reshape(block_struct.data(mask), [], channels);
    ow = reshape(block_struct.data(~mask), [], channels);
    
    % calculate means
    iw_mean = mean(iw, 1);
    ow_mean = mean(ow, 1);
    
    % OPD
    d = opd(iw_mean, ow_mean);
    
    % eigen vectors associated with positive value times mean
    px = max(d, px);
end
