function d = opd(vec_a, vec_b)
%OPD Orthogonal projection divergence

d = (vec_a * (eye(numel(vec_a)) - vec_a' / (vec_a * vec_a') * vec_a) * vec_a') + (vec_b * (eye(numel(vec_b)) - vec_b' / (vec_b * vec_b') * vec_b) * vec_b');
if 0 < d
    d = sqrt(d);
else
    d = nan;
end

end

