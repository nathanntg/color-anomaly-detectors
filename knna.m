function im_result = knna(img)
%KNN Perform the PCAG algorithm on img.

b = blockproc(img, [50 50], @knnpdf, 'PadPartialBlocks', 1, 'PadMethod', 'symmetric');
size_im = size(img);
b = b(1:size_im(1), 1:size_im(2));

im_result = 1 - b;

return;

%thresholds and parameters
thr_nomrf = 1e-4;
thr_mrf = 1e-4;
g_temp = 1;

% labels
label = cell(1, 7);

label{1} = b < thr_nomrf;

% MRF model
n_mask = ones(3);
n_mask(2, 2) = 0;
for i = 1:6
    anom_normal_cnt = -8 + 2 .* conv2(double(label{i}), n_mask, 'same');
    label{i + 1} = b < thr_mrf .* exp(1 / g_temp .* anom_normal_cnt);
end

im_result = double(label{7});

end

