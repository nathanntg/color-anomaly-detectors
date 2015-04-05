function mask = sq_mask(sz, channels, m_size, h_size)
%SQ_MASK Generate a square mask.
% sz must be an odd number represnting the mask size
mid_point = 1 + (sz - 1) / 2;
if m_size == sz
    mask = true([sz sz channels]);
else
    mask = false([sz sz channels]);
    d = (m_size - 1) / 2;
    mask(mid_point - d:mid_point + d, mid_point - d:mid_point + d, :) = true;
end
% hollow
if nargin == 4
    d = (h_size - 1) / 2;
    mask(mid_point - d:mid_point + d, mid_point - d:mid_point + d, :) = false;
end
end
    