%function [] = test_csg
%
% File:      test_csg.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.09.08
% Language:  MATLAB R2012a
% Purpose:   test the implicit constructive solid geometry module
% Copyright: Ioannis Filippidis, 2012-

cls

%% define
obstacles = init_rooms;

%% domain
dom = [-11, 6, -4, 4];
res = [100, 101];
q = domain2vec(dom, res);

%% evaluate
[bi, Dbi, D2bi] = beta_heterogenous(q, obstacles);

formula_tree = obstacles.formula_tree;
[b, Db, D2b] = biDbiD2bi2bDbD2b_csg(bi, Dbi, D2bi, formula_tree);

%% plot
ax = gca;
b(b < 0) = nan;
vsurf(ax, q, b, res)
axis(ax, 'equal')
axis(ax, 'tight')
