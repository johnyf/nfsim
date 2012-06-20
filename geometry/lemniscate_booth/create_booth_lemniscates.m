function [lemniscates] = create_booth_lemniscates(qc, a, b, e)
nobs = size(qc, 2);

lemniscates = [];
for i=1:nobs
    curqc = qc(:, i);
    cura = a(1, i);
    curb = b(1, i);
    cure = e(1, i);
    
    lemniscate = create_booth_lemniscate(curqc, cura, curb, cure);
    
    lemniscates = add_lemniscate_booth(lemniscate, lemniscates);
end

function [lemniscate] = create_booth_lemniscate(qc, a, b, e)
lemniscate.qc = qc;
lemniscate.a = a;
lemniscate.b = b;
lemniscate.e = e;

function [lemniscates] = add_lemniscate_booth(lemniscate, lemniscates)
n = size(lemniscates, 1);
n = n +1;

lemniscates(n, 1).qc = lemniscate.qc;
lemniscates(n, 1).a = lemniscate.a;
lemniscates(n, 1).b = lemniscate.b;
lemniscates(n, 1).e = lemniscate.e;
