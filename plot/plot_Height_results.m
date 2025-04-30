function plot_Height_results()
    % Load data file
    data = load('navSolCT_RAIM_ims_Opensky.mat', 'navSolutionsCT');
    user_pos = data.navSolutionsCT.usrPosLLH;
    
   % Ground truth height
    true_height = 3;  % m
    
     % Create figure window
    figure('Color', 'w', 'Position', [100 100 800 400]);
    
    % Plot estimated height
    plot(user_pos(:,3), 'LineWidth', 1.5, ...
        'Color', [0.2 0.6 0.8], ...
        'DisplayName', 'Estimated Height');
    hold on;
    
    % Plot ground truth 
    x_range = get(gca, 'XLim');  
    plot(x_range, [true_height true_height], '--', ...
        'LineWidth', 2, ...
        'Color', [0.9 0.2 0.1], ...
        'DisplayName', 'Ground Truth');
    
    % Plot styling
    grid on;
    box on;
    xlabel('Data Point Index', 'FontSize', 12);
    ylabel('Height  (m)', 'FontSize', 12);
    title('Height Estimation Results', 'FontSize', 14);
    legend('Location', 'best');
    set(gca, 'FontWeight', 'bold', 'LineWidth', 1.2);

    % Axis limits
    y_padding = 1; 
    ylim([min(user_pos(:,3))-y_padding, max(user_pos(:,3))+y_padding]);
    xlim([1, length(user_pos(:,3))]);
    
   % Statistics annotation
    text(0.75, 0.85, ...
        {sprintf('Mean estimated height: %.2f m', mean(user_pos(:,3))), ...
         sprintf('Standard deviation: %.2f m', std(user_pos(:,3)))}, ...
        'Units', 'normalized', ...
        'FontSize', 10, ...
        'BackgroundColor', [1 1 1 0.7],...
        'EdgeColor', 'k');
end