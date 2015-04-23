% algorithms to performance test
algos = {@RX_global, @rxl, @dwest, @nswtd, @mwnswtd, @pcag, @pcag, @knn};
algos_nice = {'Global RX', 'Local RX', 'DWEST', 'NSWTD', 'MW-NSWTD', 'PCAG', 'MW-PCAG', 'KNN'};

% scenes to compare
scene_files = {'beach.jpg', 'desert.jpg', 'island.jpg'};

% results
tbl = zeros(numel(algos), numel(scene_files));

for i = 1:numel(algos)
    cb = algos{i};
    
    for j = 1:numel(scene_files)
        % load scene
        scene = scene_files{j};
        s = load(sprintf('output/%s.mat', scene), 'scene');
        img = s.scene;
        
        % profile
        t = cputime;
        a = cb(img);
        e = cputime - t;
        
        % store result
        tbl(i, j) = e;
    end
end

% bar plot
b = bar(tbl);
ylabel('Time (s)');
xlabel('Algorithm');
set(gca, 'XTickLabel', algos_nice);
title('Execution Time');
print(gcf, 'exec.png', '-dpng', '-r300');