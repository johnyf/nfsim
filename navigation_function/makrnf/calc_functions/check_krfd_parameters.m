function [] = check_krfd_parameters(k, lambda, h)
if k < 2
    error('NF parameter k < 2 provided, should be >=2.')
end

if lambda <= 0
    error('NF parameter lambda <= 0 provided, should be > 0.')
end

if h <= 0
    error('NF parameter h <= 0 provided, should be > 0.')
end
