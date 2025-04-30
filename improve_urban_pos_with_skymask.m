%% Initialization and Data Loading
clearvars;
close all;
clc;

% Load WLS positioning results
load('navSolCT_WLS_1ms_Urban.mat', 'navSolutionsCT');

% Load sky mask data (azimuth vs. elevation thresholds)
skymask = table2array(readtable('skymask_A1_urban.csv'));
angles = skymask(2:end, 1);
elevations = skymask(2:end, 2);

% Ground truth coordinates (convert to ECEF)
GT_llh = [22.3198722, 114.209101777778, 3.0];% [Lat, Lon, Height]
GT_ecef = llh2ecef([deg2rad(GT_llh(1)), deg2rad(GT_llh(2)), GT_llh(3)]);

% Generate smoothed elevation thresholds using cubic spline interpolation
angles_smooth = linspace(0, 360, 3600);% 0.1-degree resolution
pp = csaps(angles, elevations, 0.99);% Smoothing parameter
elev_threshold = fnval(pp, angles_smooth);% Interpolated thresholds


%% Process each epoch
num_epochs =500;
enu_errors = zeros(num_epochs, 3);
usrPos_enhanced = zeros(num_epochs, 3);

for i = 1:num_epochs
    % Extract satellite positions and pseudoranges
    sv_xyz = reshape(navSolutionsCT.svxyzr(i, :, :), [], 3); % Satellite ECEF positions
    usr_pos = navSolutionsCT.usrPos(i, :); % Current user position (ECEF)
    pr = navSolutionsCT.rawPseudorange(i, :);
    num_sv = size(sv_xyz, 1);
    
     % Calculate azimuth and elevation for each satellite
    valid_idx = [];
    for j = 1:num_sv
       % Convert satellite position to ENU relative to ground truth
        enu = xyz2enu(sv_xyz(j, :) - GT_ecef, GT_ecef);
        az = mod(atan2d(enu(1), enu(2)) + 360, 360); % Azimuth (0-360°)
        el = atand(enu(3) / norm(enu(1:2)));  % Elevation
        
        % Find closest azimuth in sky mask
        [~, az_idx] = min(abs(angles_smooth - az));
        elev_thresh = elev_threshold(az_idx);
        
        % Check visibility against sky mask
        if el >= elev_thresh
            valid_idx = [valid_idx, j];
        end
    end
    
     % Recalculate position using visible satellites
    if length(valid_idx) >= 4
        pr_valid = pr(valid_idx); 
        sv_xyz_valid = sv_xyz(valid_idx, :);% Filtered pseudoranges
        el_valid = el_values(valid_idx);% Filtered satellite positions

        % WLS positioning with visible satellites
        weights = sind(el_valid).^2;   
        weights = weights / sum(weights);

        % 调用WLS定位
        [estusr, ~] = wlspos(pr_valid, sv_xyz_valid, usr_pos, 1e-3, weights);
        usrPos_enhanced(i, :) = estusr(1:3);
        
    else
        usrPos_enhanced(i, :) = usr_pos; 
    end
    
  
    %% Result Analysis
    % Fallback to original estimate
    R_mat = R_ecef_enu([deg2rad(GT_llh(1)), deg2rad(GT_llh(2)), GT_llh(3)]);
    enu_error = R_mat * (usrPos_enhanced(i, :)' - GT_ecef');
    enu_errors(i, :) = enu_error';

    
end

%% Result Analysis
% Original WLS errors
enu_errors_original = zeros(num_epochs, 3);
for i = 1:num_epochs
    R_mat = R_ecef_enu([deg2rad(GT_llh(1)), deg2rad(GT_llh(2)), GT_llh(3)]);
    enu_error = R_mat * (navSolutionsCT.usrPos(i, :)' - usr_pos');
    enu_errors_original(i, : ) = enu_error';
end

% Print statistics
fprintf('Mean of the original WLS error: [%.2f, %.2f, %.2f] m\n', ...
    mean(enu_errors_original));
fprintf('Mean of the enhanced WLS error: [%.2f, %.2f, %.2f] m', ...
    mean(enu_errors));





