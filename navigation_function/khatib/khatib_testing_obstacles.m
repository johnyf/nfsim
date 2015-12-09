function [obstacles] = khatib_testing_obstacles

qc = [6, 10; 10, 3; 13, 15].';
rot = repmat({eye(2) }, 1, 3);
r = {[2, 3], [2.5, 2], [1.5, 1.5] };

obstacles = create_ellipsoids(qc, rot, r);

