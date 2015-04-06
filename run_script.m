function run_script(scene_file)
%RUN_SCRIPT

% color spaces
color_spaces = {};
color_spaces{end + 1} = @(img) img;
color_spaces{end + 1} = @im_rgb2lab;
color_spaces{end + 1} = @im_rgb2upvpl;
color_spaces{end + 1} = @im_rgb2uvl;
color_spaces{end + 1} = @im_rgb2xyy;
color_spaces{end + 1} = @im_rgb2xyz;
color_spaces{end + 1} = @(img) select_channel(im_rgb2lab(img), 2:3);
color_spaces{end + 1} = @(img) select_channel(im_rgb2upvpl(img), 1:2);
color_spaces{end + 1} = @(img) select_channel(im_rgb2uvl(img), 1:2);
color_spaces{end + 1} = @(img) select_channel(im_rgb2xyz(img), [1 3]);
color_spaces{end + 1} = @(img) select_channel(im_rgb2xyy(img), [1 3]);
color_spaces{end + 1} = @(img) transform_channel(im_rgb2lab(img), 1, @(x) log(1+x));

% load file
fname = sprintf('output/%s.mat', scene_file);
if exist(fname, 'file')
    load(fname);
else
    % build scene and target
    [scene, target] = build_scene(scene_file);

    % save
    save(['output/' scene_file '.mat'], 'scene', 'target');
end

fprintf('Scene %s...\n', scene_file);

% for each color space
for j = 1:length(color_spaces)
    % get callback
    color_cb = color_spaces{j};

    % transform image
    img = color_cb(scene);

    fprintf('Color %d...\n', j);

    % run four algorithms
    % RX GLOBAL
    fname = sprintf('output/%s-%d-rx.mat', scene_file, j);
    if ~exist(fname, 'file')
        img_rx = RX_global(img);
        save(fname, 'img_rx');
    end
    
    % DWEST
    fname = sprintf('output/%s-%d-dwest.mat', scene_file, j);
    if ~exist(fname, 'file')
        img_dwest = dwest(img);
        save(fname, 'img_dwest');
    end

    % NSWTD
    fname = sprintf('output/%s-%d-nswtd.mat', scene_file, j);
    if ~exist(fname, 'file')
        img_nswtd = nswtd(img);
        save(fname, 'img_nswtd');
    end

    % MW-NSWTD
    fname = sprintf('output/%s-%d-mwnswtd.mat', scene_file, j);
    if ~exist(fname, 'file')
        img_mwnswtd = mwnswtd(img);
        save(fname, 'img_mwnswtd');
    end

    % PCAG
    fname = sprintf('output/%s-%d-pcag.mat', scene_file, j);
    if ~exist(fname, 'file')
        img_pcag = mwnswtd(img);
        save(fname, 'img_pcag');
    end
end 

end

