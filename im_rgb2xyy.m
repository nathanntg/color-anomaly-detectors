function im_xyy = im_rgb2xyy(im_rgb )
%IM_RGB2XYY Convert RGB to xyY colorspace
cf = makecform('srgb2xyz');
cf2 = makecform('xyz2xyl');
im_xyy = applycform(applycform(im_rgb, cf), cf2);
end

