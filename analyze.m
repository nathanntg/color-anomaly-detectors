% algorithms to compare
algos = {'rx', 'rxl', 'dwest', 'nswtd', 'mwnswtd', 'pcag', 'mwpcag', 'pcad', 'knna'};
algos_nice = {'Global RX', 'Local RX', 'DWEST', 'NSWTD', 'MW-NSWTD', 'PCAG', 'MW-PCAG', 'PCAD', 'KNN'};

% scenes to compare
scene_files = dir('scenes/*.jpg');
scene_files = {scene_files.name};
% scene_files = {'beach.jpg', 'desert.jpg', 'island.jpg'};

% color spaces to compare
color_spaces = {'RGB', 'L*a*b', 'u''v''L', 'uvL', 'xyY', 'XYZ', '*a*b', 'u''v''', 'uv', 'xy', 'XZ', 'log(L)*a*b', 'YCbCr', 'CbCr'};

% make comprehensive target
target = [];
for i = 1:length(scene_files)
	% load scene
	scene = scene_files{i};
	S = load(sprintf('output/%s.mat', scene));
	
	% append to target
	target = [target; S.target(:)];
end

% TABLE
% COLUMNS: algorithms
% ROWS: color spaces

% for a color space
tbl = zeros(length(color_spaces), length(algos));
for i = 1:length(color_spaces)
	for j = 1:length(algos)
		algo = algos{j};
		
		% make comprehensive output
		out = [];
		for k = 1:length(scene_files)
			scene = scene_files{k};
			fname = sprintf('output/%s-%d-%s.mat', scene, i, algo);
			
			% load
			S = load(fname);
			f = fieldnames(S);
			
			% out
			cur_out = S.(f{1});
			
			out = [out; cur_out(:)];
		end
		
		% calculate AUC
		[~, ~, ~, auc] = roc_anomaly(target, out);
        title(sprintf('%s with %s color space', algos_nice{j}, color_spaces{i}));
		print(gcf, sprintf('roc/%d-%s.png', i, algo), '-dpng', '-r300');
        
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
print(gcf, 'bar.png', '-dpng', '-r300');