function [tpr, fpr, th, auc] = roc_anomally(im_target, im_out, mn, mx)
%ROC_ANOMALLY Plot receiver operating characteristic and return values.
%   Takes a target image and the output of an anomally detector.
%   Shows a plot of the ROC curve.
%   The anomally detector response is automatically normalized, unless mn 
%   and max are specified.

% remove color component
if 3 == ndims(im_target)
    im_target = (mean(im_target, 3) >= 0.5);
end

% reshape
v_target = im_target(:);
v_out = im_out(:);

if nargin < 3
    mn = min(v_out);
    mx = max(v_out);
end
if abs(mn - 0) > 1e-16  || abs(mx - 1) > 1e-16
    v_out = (v_out - mn) / (mx - mn);
end

plotroc(v_target', v_out');
[tpr, fpr, th] = roc(v_target', v_out');
auc = trapz(fpr, tpr);
fprintf('AUC: %.5f\n', auc);

end

