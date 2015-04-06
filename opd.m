function d = opd(vec_a, vec_b)
%OPD Orthogonal projection divergence

d = (vec_a * osp(vec_b) * vec_a') + (vec_b * osp(vec_a) * vec_b');
if 0 <= d
    d = sqrt(d);
else
    d = nan;
end

end

