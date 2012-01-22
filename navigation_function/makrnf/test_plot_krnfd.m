function [] = test_plot_krnfd

q = [0, 0;
     10, 0;
     0, 10;
     0, 20].';
 
r = [0.5, 0.5, 0.01, 0.01];
 
cur_agent = 1;

qd1 = [10, 10].';
dc1 = 4;
k = 8;
lambda = 1;
h = 10;

xmin = -15;
xmax = +15;

ymin = -15;
ymax = +15;

n = 40;
m = 50;
for i=1:n
    x(1, i) = i/n *(xmax-xmin) +xmin;
    for j=1:m
        q(:, 1) = [(xmax -xmin)*i/n+xmin, (ymax -ymin)*j/m+ymin].';
        
        y(1, j) = j/m *(ymax -ymin) +ymin;
        z(j, i) = krnfd(q, r, cur_agent, qd1, dc1, k, lambda, h);
    end
end

surf(x, y, z)
