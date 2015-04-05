function P = osp(vec)
%OSP Orthoogonal Subspace Projection

% http://www.umbc.edu/rssipl/pdf/TGRS/tgrs_OSP_3_05.pdf

P = eye(size(vec, 2)) - vec' / (vec * vec') * vec;

end
