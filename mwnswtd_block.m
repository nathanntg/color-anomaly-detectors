function px = mwnswtd_block(block_struct)
%MWNSWTD_BLOCK Perform the multi-window nested window anomaly detection
%algorithm.
%   Called for a single block fof the image.

% square odd dimension
block_size = size(block_struct.data, 1);
channels = size(block_struct.data, 3);

% create inner window (size 1)
iw_size = 1;
mask = sq_mask(block_size, channels, iw_size);
iw_mean = mean(reshape(block_struct.data(mask), [], channels), 1);

% mask to pass into loop
mask = sq_mask(block_size, channels, iw_size + 2, iw_size);
ow_mean = mean(reshape(block_struct.data(mask), [], channels), 1);

px = nan;
for w_size = (iw_size + 2):2:(block_size - 2)
	% mask is already correct for middle window
	mw_mean = ow_mean;
	
	% redraw mask for outerwindow
	mask = sq_mask(block_size, channels, w_size + 2, w_size);
	ow_mean = mean(reshape(block_struct.data(mask), [], channels), 1);
	
    % use OSP based on outer window to project both inner and middle window
    p_outer = osp(ow_mean);
    d = (iw_mean * p_outer * iw_mean') + (mw_mean * p_outer * mw_mean');
    if 0 <= d
        d = sqrt(d);
    else
        d = nan;
    end
    
    % eigen vectors associated with positive value times mean
    px = max(d, px);
end

end
