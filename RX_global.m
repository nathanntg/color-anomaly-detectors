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

for i=1:img_size1
    for j=1:img_size2
        % Locate center pixel and convert to column vector
        r=reshape(Data(i,j,:),channels,[]);

        % Run RX detector on center pixel
        d(1+i,1+j)=(r-mu)'*K^-1*(r-mu);
    end
end
img_out=d;
