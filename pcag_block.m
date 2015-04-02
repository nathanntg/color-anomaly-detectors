function px = pcag_block(block_struct)
%PCAG Perform the PCAG algorithm on img.

% square odd dimension
block_size = size(block_struct.data);
channels = size(block_struct.data, 3);

vals = reshape(block_struct.data, [], channels);
[~, p_sc, p_la] = pca(vals);

n = 0;
p_nm = size(p_sc, 2);
rm = ((block_size(1) * block_size(2)) - ((block_size(1) - 2) * (block_size(2) - 2))) / 2;
for c = 1:p_nm
    s = sort(p_sc(:, c));
    n = n + max(diff(s(rm:end - rm))) * p_la(c);
end
n = n / sum(p_la);

px = n * ones(block_size(1:2));
end
