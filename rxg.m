function im_result = rxg(img)
% Perform RX algorithm on global of image

% Dimensions of block
[height, width, channels] = size(img);

% Separate block into color channels to calculate K matrix
cc = reshape(img, [], channels);
k_inv = inv(cov(cc));

% Create mean color column vector
mu = mean(cc);

% zero-mean
cc_rows = size(cc, 1);
cc = cc - (ones(cc_rows, 1) * mu);

% Preallocate
im_result = zeros(cc_rows, 1);

for i = 1:cc_rows
    % Locate center pixel and convert to column vector
    r = cc(i, :);

    % Run RX detector on center pixel
    im_result(i) = r * k_inv * r';
end

im_result = reshape(im_result, height, width);
