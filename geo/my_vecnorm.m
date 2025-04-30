% Calculate vector norm
function norms = my_vecnorm(A, p, dim)
    if nargin < 2
        p = 2; % Default Euclidean norm
    end
    if nargin < 3
        dim = 1; % Default norm calculation by column
    end
    norms = sum(abs(A).^p, dim).^(1/p);
end
