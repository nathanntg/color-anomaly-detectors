function im_upvpl = im_rgb2upvpl(im_rgb )
%IM_RGB2UPVPL Convert RGB to u'v'L colorspace
cf = makecform('srgb2xyz');
cf2 = makecform('xyz2upvpl');
im_upvpl = applycform(applycform(im_rgb, cf), cf2);
end

