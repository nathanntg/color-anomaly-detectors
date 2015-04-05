function [scene, target] = build_scene(file, num_anomalies)
%BUILD_SCENE Reads image file and adds anomalies to it.
%   Returns image and target map showing anomalies. Anomalies are luminance
%   adjusted to match the surroundings. Defaults to 3 anomalies.

if nargin < 2
    num_anomalies = 3;
end

% settings
desired_width = 1536;
anomaly_height = 10; % all anomalies are normalized to 100 high, so use height as normalizing factor

% read a scene
scene = imread(['scenes/' file]);
scene = normalize_image(imresize(scene, [nan desired_width]));

% make target
target = false(size(scene, 1), size(scene, 2));

% anomaly files
anomaly_files = dir('anomalies/*.png');
anomaly_files = {anomaly_files.name};
perm = randperm(length(anomaly_files));
anomaly_files = anomaly_files(perm);

% scene luminance information
scene_luminance = rgb2lab(scene);
scene_luminance = scene_luminance(:, :, 1);

for j = 1:num_anomalies
    % read an anomaly
    [anom, ~, anom_mask] = imread(['anomalies/' anomaly_files{j}]);

    % resize
    anom = imresize(anom, [anomaly_height nan]);
    anom_mask = imresize(anom_mask, [anomaly_height nan]);

    % rotate
    ang = rand * 365;
    anom = normalize_image(imrotate(anom, ang, 'bicubic'));
    anom_mask = imrotate(anom_mask, ang, 'bilinear');

    % figure out threshold for alpha (want enough of the anomaly, but not grain edges)
    th = 255;
    while sum(sum(anom_mask >= th)) < (0.5 * anomaly_height * anomaly_height)
        th = th - 5;
    end

    % position
    pos = rand(1, 3) .* (size(scene) - size(anom));
    pos = round(pos(1:2));

    % average luminance
    med_y_scene = median(median(scene_luminance(pos(1):pos(1) + size(anom, 1) - 1, pos(2):pos(2) + size(anom, 2) - 1)));

    % adjust luminance
    anom = rgb2lab(anom);
    anom_y = anom(:, :, 1);
    med_y_anom = median(median(anom_y(anom_mask >= th)));
    anom(:, :, 1) = anom_y * (med_y_scene / med_y_anom);
    anom = lab2rgb(anom);

    % build mask for all channels
    single_mask = (anom_mask >= th);
    mask = single_mask;
    while size(mask, 3) < size(scene, 3)
        mask = cat(3, mask, single_mask);
    end

    % local scene
    scene_local = scene(pos(1):pos(1) + size(anom, 1) - 1, pos(2):pos(2) + size(anom, 2) - 1, :);
    % replace channels
    scene_local(mask) = anom(mask);
    scene(pos(1):pos(1) + size(anom, 1) - 1, pos(2):pos(2) + size(anom, 2) - 1, :) = scene_local;
    
    % update target
    target(pos(1):pos(1) + size(anom, 1) - 1, pos(2):pos(2) + size(anom, 2) - 1) = target(pos(1):pos(1) + size(anom, 1) - 1, pos(2):pos(2) + size(anom, 2) - 1) | single_mask;
end

end

