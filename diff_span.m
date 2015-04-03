function d = diff_span(v, n)
%DIFF_SPAN Differences in vector with a span of n.
d = v(1 + n:end) - v(1:end - n);
end