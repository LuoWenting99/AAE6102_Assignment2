function plot_position_results()
    % Load data file
    data = load('navSolCT_RAIM_ims_Opensky.mat', 'navSolutionsCT');
    user_pos = data.navSolutionsCT.usrPosLLH; % [Lat, Lon, Height], 4067б┴3
    
    % Ground truth coordinates [Lat, Lon, Height]
    true_pos = [22.328444770087565, 114.1713630049711, 3];
    
    % Create figure window
    figure('Color', 'w', 'Position', [100 100 800 600]);
    
    % Plot ground truth
    scatter(true_pos(2), true_pos(1), 120, 'pentagram',...
           'MarkerFaceColor', [0.9 0.2 0.1],...
           'MarkerEdgeColor', 'k',...
           'LineWidth', 1.5,...
           'DisplayName', 'Ground Truth');
       
    hold on;    
    % Plot estimated positions
    scatter(user_pos(:,2), user_pos(:,1), 15, 'filled',...
           'MarkerFaceColor', [0.2 0.6 0.8],...
           'MarkerEdgeColor', 'none',...
           'DisplayName', 'Estimated Positions');

    % Plot styling
    grid on;
    box on;
    xlabel('Longitude (бу)');
    ylabel('Latitude (бу)');
    title('Estimated vs. True User Position');
    legend('Location', 'best');
    set(gca, 'FontSize', 12, 'FontWeight', 'bold');
    
    % Dynamic axis limits
    lon_pad = 0.0005;
    lat_pad = 0.0003;
    xlim([min(user_pos(:,2))-lon_pad, max(user_pos(:,2))+lon_pad]);
    ylim([min(user_pos(:,1))-lat_pad, max(user_pos(:,1))+lat_pad]);
    
    % Height annotation
    text(0.02, 0.95,...
        sprintf('True Height: %.2f m', true_pos(3)),...
        'Units', 'normalized',...
        'FontSize', 10,...
        'BackgroundColor', [1 1 1 0.7]);
end