function [tpr, fpr, th, auc] = roc_anomally(im_target, im_out)
%ROC_ANOMALLY Plot receiver operating characteristic and return values.
%   Takes a target image and the output of an anomally detector.
%   Shows a plot of the ROC curve.

% remove color component
if 3 == ndims(im_target)
    im_target = (mean(im_target, 3) >= 0.5);
end

% reshape
v_target = im_target(:);
v_out = im_out(:);

% sort target accordingly
[th, ind] = sort(v_out, 'descend');
s_target = v_target(ind);

num = numel(s_target);
tp = 0; fp = 0;
fn = sum(s_target); tn = num - fn;
fpr = zeros(1 + num, 1); tpr = zeros(1 + num, 1);
for v = 1:num
	if s_target(v)
		tp = tp + 1;
		fn = fn - 1;
	else
		fp = fp + 1;
		tn = tn - 1;
	end
	tpr(1 + v) = tp / (tp + fn);
	fpr(1 + v) = fp / (tn + fp);
end

% make plot
figure;
plot(fpr, tpr, 'b', 'LineWidth', 2.);
auc = trapz(fpr, tpr);
legend(sprintf('ROC (AUC: %.3f)', auc), 'Location', 'SouthEast');
hold on; plot([0; 1], [0; 1], '-', 'Color', [.8 .8 .8]); hold off;
xlim([0 1]); ylim([0 1]);
xlabel('FPR'); ylabel('TPR');

end

