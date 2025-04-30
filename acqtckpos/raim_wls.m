function [estusr, dop, fault_sv] = raim_wls(prvec, svxyzmat, cn0, initpos, tol, max_iter)
%RAIM_WLS Weighted RAIM algorithm for GNSS positioning
% INPUTS:
%   prvec    : Pseudorange measurements (Nx1)
%   svxyzmat : Satellite positions (Nx3)
%   cn0      : C/N0 values for weighting (Nx1)
%   initpos  : Initial guess [x,y,z,clock_bias]
%   tol      : Convergence tolerance
%   max_iter : Max iterations
% OUTPUTS:
%   estusr   : Estimated position and clock bias
%   dop      : DOP values
%   fault_sv : Detected faulty satellite indices

% Initialize parameters
num_sats = length(prvec);
weight = 10.^(cn0/10); % Convert C/N0 to weights
H = zeros(num_sats, 4);
residuals = zeros(num_sats, 1);
estusr = initpos(:);
fault_sv = [];

for iter = 1:max_iter
    % Calculate design matrix and residuals
    for i = 1:num_sats
        rho_hat = norm(svxyzmat(i,:) - estusr(1:3)');
        H(i,1:3) = (estusr(1:3)' - svxyzmat(i,:)) / rho_hat;
        H(i,4) = 1;
        residuals(i) = prvec(i) - (rho_hat + estusr(4));
        fprintf('estusr(1:3) Î¬¶È: %s\n', mat2str(size(estusr(1:3))));
        fprintf('svxyzmat(i,:) Î¬¶È: %s\n', mat2str(size(svxyzmat(i,:))));
    end
    
    % Weighted least squares
    W = diag(weight);
    HWH = H' * W * H;
    HWH_inv = inv(HWH + 1e-6*eye(4)); % Regularization
    dx = HWH_inv * (H' * W * residuals);
    estusr = estusr + dx;
    
    % Check convergence
    if norm(dx) < tol
        break;
    end
end

% Calculate test statistic (Weighted SSE)
sse = residuals' * W * residuals;
dof = num_sats - 4;
threshold = chi2inv(0.99, dof); % 99% confidence

% Fault detection
if sse > threshold
    % Identify faulty satellite (largest normalized residual)
    normalized_res = abs(residuals) ./ sqrt(diag(W));
    [~, fault_idx] = max(normalized_res);
    fault_sv = fault_idx;
    
    % Recalculate without faulty SV
    if num_sats >= 5
        prvec(fault_sv) = [];
        svxyzmat(fault_sv,:) = [];
        cn0(fault_sv) = [];
        [estusr, dop] = raim_wls(prvec, svxyzmat, cn0, initpos, tol, max_iter);
    end
end

% DOP calculation
dop = sqrt(trace(HWH_inv(1:3,1:3)));
end