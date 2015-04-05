% each scene
scene_files = dir('scenes/*.jpg');
scene_files = {scene_files.name};

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
color_spaces{end + 1} = @(img) select_channel(im_rgb2lab(img), [1 3]);

% tuned for my laptop (3 workers)
parpool('local', 3);

% build
for i = 1:length(scene_files)
    % file name
    scene_file = scene_files{i};
    
    % build scene and target
    [scene, target] = build_scene(scene_file);
    
    % save
    save(['output/' scene_file '.mat'], 'scene', 'target');
    
    fprintf('Scene %s...\n', scene_file);
    
    % for each color space
    for j = 1:length(color_spaces)
        % get callback
        color_cb = color_spaces{j};
        
        % transform image
        img = color_cb(scene);
        
        fprintf('Color %d...\n', j);
        
        % run four algorithms
        fname = sprintf('output/%s-%d-dwest.mat', scene_file, j);
        if exist(fname, 'file')
            load(fname);
        else
            img_dwest = dwest(img);
            save(fname, 'img_dwest');
        end
        
        fname = sprintf('output/%s-%d-nswtd.mat', scene_file, j);
        if exist(fname, 'file')
            load(fname);
        else
            img_nswtd = nswtd(img);
            save(fname, 'img_nswtd');
        end
        
        fname = sprintf('output/%s-%d-mwnswtd.mat', scene_file, j);
        if exist(fname, 'file')
            load(fname);
        else
            img_mwnswtd = mwnswtd(img);
            save(fname, 'img_mwnswtd');
        end
        
        fname = sprintf('output/%s-%d-pcag.mat', scene_file, j);
        if exist(fname, 'file')
            load(fname);
        else
            img_pcag = mwnswtd(img);
            save(fname, 'img_pcag');
        end
    end 
end

delete(gcp);