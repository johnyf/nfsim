function [predicates] = define_predicate_array(letter, m)

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
