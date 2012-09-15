function [predicates] = define_predicate_array(letter, n)

predicates = cell(1, n);
for i=1:n
    predicates{1, i} = [letter, num2str(i) ];
end
