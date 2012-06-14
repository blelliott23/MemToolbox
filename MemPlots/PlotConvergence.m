function figHand = PlotConvergence(stored, paramNames)
  % Show traces for each variable for each MCMC chain. Very simple way to
  % diagnose convergence: They should look the same as each other.
  figHand = figure;
  N = length(paramNames);
  colors = palettablecolors(max(stored.chain));
  for p=1:N
    % Make trace plots
    h = subplot(N,3,sub2ind([3 N],1:2,[p p]));
    for c=1:max(stored.chain)
      vals(:,c) = stored.vals(stored.chain==c, p);
      plot(vals(:,c), 'Color', colors(c,:));
      set(gca, 'box', 'off');
      hold on;
    end
    lims = axis(gca);
    set(gca, 'XTick', []);
    title(paramNames{p}, 'FontSize', 15);
    
    % Make overlapping histograms
    h2 = subplot(N,3,sub2ind([3 N],3,p));
    yBins = linspace(lims(3), lims(4), 30)';
    for c=1:max(stored.chain)
      cnt = histc(vals(:,c), yBins);
      B = barh(yBins, cnt, 'hist');
      set(B, 'EdgeColor', 'none', 'FaceColor', ...
        colors(c,:)); %'FaceAlpha', .2 
      hold on;
    end    
    set(gca, 'box', 'off');
    % Match axes of trace plots
    ylim([lims(3), lims(4)]);
    set(gca, 'YTick', []);
    set(gca, 'XTick', []);
    
    % Make trace plots a bit wider
    pos = get(h, 'Position');
    pos(3) = pos(3) + 0.05;
    set(h, 'Position', pos); 
  end
  set(gcf,'Color',[1 1 1]);
end