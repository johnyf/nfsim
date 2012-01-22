function [b, Db, D2b] = beta_sphere(q, qc, r)
% \beta, \nabla\beta, D^2\beta
% of product of multiple spheres \beta_i
%
% inputs
%   q = calculation points
%     = [#dimensions x #points]
%   qc = sphere centers
%      = [#dimensions x #sphere_obstacles]
%   r = sphere radii = [1 x (#sphere_obstacles)]
%
% Remark: This calculates b, Db, D2b directly for spheres.
%         You can achieve exactly the same by first calling:
%         [bi, Dbi, D2bi] = beta_quadrics(q, quadrics)
%         and then converting individual obstacle function values and
%         derivatives to their product and its derivatives:
%         [b, Db, D2b] = biDbiD2bi2bDbD2b(bi, Dbi, D2bi)
%
% Note: same code included in KRNFS to optimize speed.

% obstacles 1,...,M (per q, many qc)
n = size(q,2);
b = ones(1, size(q) );
Wsum = zeros(size(q) );

% any internal obstacles?
if ~isempty(r)
    % obstacles 1,...,M (single q, many qc)
    for i=1:n
        %% beta
        q_qc = bsxfun(@minus, q(:,i), qc);
        bi = vnorm(q_qc, 1, 2).^2 -r.^2;
        b(1,i) = b(1,i) .*prod(bi);
        
        %% gradbeta
        Wq_qc = bsxfun(@rdivide, q_qc, beta1toM); % weighted vector sum...
        Wsum(:,i) = sum(Wq_qc, 2); % ...completed
    end
end

b(b < 0) = 0;
Db = 2 .*Wsum;
% todo: add calculation of D2b specifically for product of spheres
D2b = 'not yet implemented';

%if isempty(find(b == 0, 1) ) == 0
%    warning('Configuration q or goal qg within obstacle!')
%end
