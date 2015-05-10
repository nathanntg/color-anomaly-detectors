% algorithms to compare
algos = {'rx', 'nswtd', 'mwpcag'};
algos_nice = {'Global RX', 'NSWTD', 'MW-PCAG'};

% scenes to compare
scene_files = {{'beach.jpg', 'beach2.jpg', 'beach3.jpg'}, {'desert.jpg', 'desert2.jpg'}, {'forest.jpg', 'forest2.jpg'}, {'island.jpg', 'island2.jpg'}, {'mountain.jpg', 'mountain2.jpg'}, {'ocean.jpg'}};
scene_nice = {'Beach', 'Desert', 'Forest', 'Arid', 'Mountain', 'Ocean'};

% color spaces to compare
color_space = 'L*a*b';
color_space_idx = 2;

% TABLE
% COLUMNS: environment
% ROWS: color spaces

% for a color space
tbl = zeros(length(scene_files), length(algos));
for i = 1:length(scene_files)
    % current scene files
    cur_scene_files = scene_files{i};
    
    % make comprehensive target
    target = [];
    for j = 1:length(cur_scene_files)
        % load scene
        scene = cur_scene_files{j};
        fname = sprintf('output/%s.mat', scene);
        S = load(fname);

        % append to target
        target = [target; S.target(:)];
    end
    
    % for each algorithm
    for j = 1:length(algos)
		algo = algos{j};
		
		% make comprehensive output
		out = [];
		for k = 1:length(cur_scene_files)
			scene = cur_scene_files{k};
			fname = sprintf('output/%s-%d-%s.mat', scene, color_space_idx, algo);
			
			% load
			S = load(fname);
			f = fieldnames(S);
			
			% out
			cur_out = S.(f{1});
			
			out = [out; cur_out(:)];
		end
		
		% calculate AUC
		[~, ~, ~, auc] = roc_anomaly(target, out);
        title(sprintf('%s for %s scenes', algos_nice{j}, scene_nice{i}));
		print(gcf, sprintf('roc/%s-%s.png', scene_nice{i}, algo), '-dpng', '-r300');
        
        % close figure window
        close;
		
		% store AUC
		tbl(i, j) = auc;
    end
end

% bar plot
b = bar(tbl);
ylim([0.6 1.0]);
ylabel('AUC');
xlabel('Color space');
legend(b, algos, 'Location', 'EastOutside');
set(gca, 'XTickLabel', color_spaces);
title('Comparative Performance');
print(gcf, 'bar-environ.png', '-dpng', '-r300');