function img_tc = transform_channel(img, channel, cb)
%TRANSFORM_CHANNEL Apply callback to channel(s).
img_tc = img;
img_tc(:, :, channel) = cb(img_tc(:, :, channel));
end

