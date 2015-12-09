function [predicates] = define_predicate_array(letter, m)
%
% input
%   letter = string which will be combined with numbers to produce the
%            names of the predicates
%   m = number of predicates to produce, or array of values
%     = scalar | [i1, i2, ... ]

if isscalar(m)
    pred = 1:m;
else
    pred = m;
end

n = size(pred, 2);
predicates = cell(1, n);
for i=1:n
    curpred = pred(1, i);
    predicates{1, i} = [letter, num2str(curpred) ];
end
