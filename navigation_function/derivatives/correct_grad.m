function [grad_new] = correct_grad(grad)
% File:      correct_grad.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2010.08.20 - 2011.07.30
% Language:  MATLAB R2011a
% Purpose:   predefined step length in gradient direction
% Copyright: Ioannis Filippidis, 2010-

ds = 1e-3;
normgrad = normvec(grad, 'p', 2);
grad_new = normgrad .*ds;

% alternative which slows down for increased gradient norms
%grad_new = normgrad .*ds ./(1 +10 *normgrad);
