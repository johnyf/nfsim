function [] = check_biDbiD2bi(bi, Dbi, D2bi)
%% multiple obstacles ?
if iscell(D2bi)
    
elseif iscell(Dbi) && iscell(D2bi)
    multi_check(bi, Dbi, D2bi)
else
    single_check(bi, Dbi, D2bi)
end

function [] = single_check(bi, Dbi, D2bi)
[nobs, npnt1] = size(bi);
[ndim1, npnt2] = size(Dbi);
[nobs2, npnt3] = size(D2bi);
[ndim2, ndim3] = size(D2bi{1, 1} );

msg = '';

if nobs ~= 1
    msg = 'nobs = size(bi, 1) ~= 1, but Dbi is not cell.';
end

if npnt1 ~= npnt2
    msg = ['npnt = size(bi, 2) = ', num2str(npnt1), ' ~= ', num2str(npnt2), ' = size(Dbi, 2)'];
end

if npnt1 ~= npnt3
    msg = ['npnt = size(bi, 1) = ', num2str(npnt1), ' ~= ', num2str(npnt3), ' = size(D2bi, 2)'];
end

if npnt2 ~= npnt3
    msg = ['npnt = size(Dbi, 2) = ', num2str(npnt1), ' ~= ', num2str(npnt3), ' = size(D2bi, 2)'];
end

if nobs2 ~= 1
    msg = 'nobs = size(D2bi, 1) ~= 1, but Dbi is not cell.';
end

if ndim1 ~= ndim2
    msg = ['ndim = size(Dbi, 1) = ', num2str(ndim1), ' ~= ', num2str(ndim2), ' = size(D2bi{1, 1}, 1)'];
end

if ndim2 ~= ndim3
    msg = ['Hessian D2bi{1, 1} is not square, it is', num2str(ndim2), ' x ', num2str(ndim3) ];
end

if isempty(msg)
    return
end

error(msg)

function [] = multi_check(bi, Dbi, D2bi)
[nobs1, npnt1] = size(bi);
[nobs2, m] = size(Dbi);
[ndim1, npnt2] = size(Dbi{1, 1} );
[nobs3, npnt3] = size(D2bi);
[ndim2, ndim3] = size(D2bi{1, 1} );

msg = '';

if nobs1 ~= nobs2
    msg = ['nobs = size(bi, 1) = ', num2str(nobs1), ' ~= ', num2str(nobs2), ' = size(Dbi, 1)'];
end

if nobs1 ~= nobs3
    msg = ['nobs = size(bi, 1) = ', num2str(nobs1), ' ~= ', num2str(nobs3), ' = size(D2bi, 1)'];
end

if npnt1 ~= npnt3
    msg = ['npnt = size(bi, 2) = ', num2str(npnt1), ' ~= ', num2str(npnt3), ' = size(D2bi, 2)'];
end

if nobs2 ~= nobs3
    msg = ['size(Dbi, 1) = ', num2str(nobs2), ' ~= ', num2str(nobs3), ' = size(D2bi, 1)'];
end

if npnt2 ~= npnt3
    msg = ['npnt = size(Dbi{1, 1}, 2) = ', num2str(npnt2), ' ~= ', num2str(npnt3), ' = size(D2bi, 2)'];
end

if m ~= 1
    msg = ['Dbi is cell but size(Dbi, 2) = ', num2str(m), ' ~= 1'];
end

if ndim1 ~= ndim2
    msg = ['ndim = size(Dbi, 1) = ', num2str(ndim1), ' ~= ', num2str(ndim2), ' = size(D2bi{1, 1}, 1)'];
end

if ndim2 ~= ndim3
    msg = ['Hessian D2bi{1, 1} is not square, it is', num2str(ndim2), ' x ', num2str(ndim3) ];
end

if isempty(msg)
    return
end

error(msg)
