% each scene
scene_files = dir('scenes/*.jpg');
scene_files = {scene_files.name};

% tuned for my laptop (3 workers)
parpool('local', 3);

% build
parfor i = 1:length(scene_files)
    run_script(scene_files{i});
end

delete(gcp);