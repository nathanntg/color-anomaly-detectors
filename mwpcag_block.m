function px = mwpcag_block(block_struct, min_size, max_size)
%MWPCAG_BLOCK Perform the MW-PCAG algorithm on img

% gap between pixels
diff_num = 2;

% square odd dimension
block_size = size(block_struct.data);
channels = size(block_struct.data, 3);

vals = reshape(block_struct.data, [], channels);
[~, p_sc, p_la] = pca(vals, 'Algorithm', 'svd', 'Centered', false);

ret = zeros([size(vals, 1) 1]);

p_nm = size(p_sc, 2);
for c = 1:p_nm
    [s, s_i] = sort(p_sc(:, c));
    
    % forward
    [fm, fm_i] = max(diff_span(s(min_size:max_size), diff_num));
    
    % backward
    [bm, bm_i] = max(diff_span(s(end - max_size:end - min_size), diff_num));
    
    % largest
    if fm > bm
        fm_i = min_size - 1 + fm_i;
        ret(s_i(1:fm_i)) = ret(s_i(1:fm_i)) + (fm * p_la(c));
    else
        bm_i = numel(s) - max_size - 1 + bm_i + diff_num;
        ret(s_i(bm_i:end)) = ret(s_i(bm_i:end)) + (bm * p_la(c));
    end
end

% normalize
% restore shape
px = reshape(ret / sum(p_la), block_size(1), block_size(2));

end
