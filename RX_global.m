function img_out = RX_global(Data)
% Perform RX algorithm on global of image

% Dimensions of block
img_size1=size(Data,1);
img_size2=size(Data,2);
channels=size(Data,3);

% Separate block into color channels to calculate K matrix
CC=reshape(Data,[],channels);
K=cov(CC);

% Create mean color column vector
mu=mean(CC)';

% Preallocate
img_out = zeros(img_size1, img_size2);

for i=1:img_size1
    for j=1:img_size2
        % Locate center pixel and convert to column vector
        r = squeeze(Data(i, j, :));

        % Run RX detector on center pixel
        img_out(i,j)=(r-mu)'/K*(r-mu);
    end
end
