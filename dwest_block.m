function px = dwest_block(block_struct)
%DWEST Perform the DWEST algorithm on img.

% square odd dimension
block_size = size(block_struct.data, 1);
channels = size(block_struct.data, 3);

px = nan;
for iw_size = 1:2:(block_size - 4)
    % update mask
    mask = sq_mask(block_size, channels, iw_size);
    
    % extract windows
    iw = reshape(block_struct.data(mask), [], channels);
    ow = reshape(block_struct.data(~mask), [], channels);
    
    % calculate means
    iw_mean = mean(iw, 1);
    ow_mean = mean(ow, 1);
    
    % centered data
    iw_centered = bsxfun(@minus, iw, iw_mean);
    ow_centered = bsxfun(@minus, ow, ow_mean);
    
    % calculate covariance
    iw_cov = (iw_centered' * iw_centered) / (size(ow_centered, 1) - 1);
    ow_cov = (ow_centered' * ow_centered) / (size(ow_centered, 1) - 1);
    
    % eigenvalues difference in covariance
    [e_vec, e_val] = eig(iw_cov - ow_cov);
    
    % eigen vectors associated with positive value times mean
    px = max(abs(sum((ow_mean - iw_mean) * e_vec(:, diag(e_val) > 0))), px);
end
