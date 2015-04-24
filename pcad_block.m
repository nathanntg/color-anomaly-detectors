function px = pcad_block(block_struct, d)
%PCAD_BLOCK Perform the PCAD algorithm on img

% square dimension
block_size = size(block_struct.data);
channels = size(block_struct.data, 3);

% PCA
vals = reshape(block_struct.data, [], channels);
[~, p_sc, p_la] = pca(vals, 'Algorithm', 'svd', 'Centered', false);

% resuable values
pad = nan(d, 1);
p_nm = size(p_sc, 2);
ret = zeros(size(p_sc));

for c = 1:p_nm
    [s, s_i] = sort(p_sc(:, c));
    
    ret(s_i, c) = max(s - [pad; s(1:end-d)], [s(1 + d:end); pad] - s);
end

% Euclidian distance
% restore shape
px = reshape(sqrt(sum(ret .^ 2, 2)), block_size(1), block_size(2));

end
