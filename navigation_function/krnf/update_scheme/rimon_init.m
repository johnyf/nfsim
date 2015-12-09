function [known_world] = rimon_init(known_world)
% File:      rimon_init.m
% Author:    Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:      2011.05.02 - 2011.07.30
% Language:  MATLAB R2011a
% Purpose:   initializes krnf known_world
% Copyright: Ioannis Filippidis, 2010-

known_world.imin = 1;
known_world.M = 0;

known_world.e0 = [];
known_world.e0u = [];

known_world.ei = [];
known_world.eiold = [];

known_world.eiu = [];

known_world.ei01 = [];
known_world.ei02 = [];

known_world.ei21 = [];
known_world.ei22 = [];

known_world.ei3 = [];

known_world.ai21 = [];
known_world.ai22 = [];
known_world.ai23 = [];

known_world.ai01 = [];
known_world.ai02 = [];
known_world.ai03 = [];

known_world.sQii = 0;
