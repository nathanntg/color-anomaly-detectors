function img_out = RX_global(Data)
% Perform RX algorithm on global of image

% Dimensions of block
img_size1=size(Data,1);
img_size2=size(Data,2);
channels=size(Data,3);

% Separate block into color channels to calculate K matrix
CC = reshape(Data,[],channels);
Kinv = inv(cov(CC));

% Create mean color column vector
mu = mean(CC);

% zero-mean
CCrows = size(CC, 1);
CC = CC - (ones(CCrows, 1) * mu);

% Preallocate
img_out = zeros(CCrows, 1);

for i = 1:CCrows
    % Locate center pixel and convert to column vector
    r = CC(i, :);

    % Run RX detector on center pixel
    img_out(i)= r * Kinv * r';
end

img_out = reshape(img_out, img_size1, img_size2);

