function P = knnpdf(block)

sz = block.blockSize;
channels = size(block.data, 3);

% variables
kn = 100;
n = sz(1) * sz(2);
features = zeros(n, channels);

for i = 1:channels
    temp = block.data(:, :, i);
    features(:, i) = double(temp(:));
end

X = features;
Y = features;

[~, D] = knnsearch(X, Y, 'K', kn);
P = kn ./ (n .* (pi .* (D(:, kn) + 1) .^ 2));
P = reshape(P, sz(1), sz(2));

end