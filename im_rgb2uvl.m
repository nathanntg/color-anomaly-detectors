function im_uvl = im_rgb2uvl(im_rgb )
%IM_RGB2LAB Convert RGB to uvL colorspace
cf = makecform('srgb2xyz');
cf2 = makecform('xyz2uvl');
im_uvl = applycform(applycform(im_rgb, cf), cf2);
end

