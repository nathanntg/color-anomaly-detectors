function img_ss = select_channel(img, channels)
%SELECT_CHANNEL Select specific channel(s).
img_ss = img(:, :, channels);
end

