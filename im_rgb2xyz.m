function im_xyz = im_rgb2xyz(im_rgb)
%IM_RGB2XYZ Convert RGB to XYZ colorspace
cf = makecform('srgb2xyz');
im_xyz = applycform(im_rgb, cf);
end

