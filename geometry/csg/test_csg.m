%function [] = test_csg
%test the implicit constructive solid geometry module
%
% 2012.09.08 (c) Ioannis Filippidis, jfilippidis@gmail.com

cls

%% define
obstacles = init_rooms;

%% domain
dom = [-11, 6, -4, 4];
res = [100, 101];
q = dom2vec(dom, res);

%% evaluate
[b, Db, D2b] = beta_csg(q, obstacles, 0);

%% plot
ax = gca;
b(b < 0) = nan;
vsurf(ax, q, b, res)
axis(ax, 'equal')
axis(ax, 'tight')
