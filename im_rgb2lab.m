function im_lab = im_rgb2lab(im_rgb )
%IM_RGB2LAB Convert RGB to L*a*b colorspace
cf = makecform('srgb2lab');
im_lab = applycform(im_rgb, cf);
end

