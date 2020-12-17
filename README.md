# Navigation Function Toolbox for MATLAB

## Summary
Compute Navigation Function trajectories among focally admissible obstacles.
Licensed under the 2-clause BSD.

## Description
Motion planning with [Navigation Functions](http://www.sciencedirect.com/science/article/pii/019688589090017S) on [focally admissible worlds](http://ieeexplore.ieee.org/xpls/abs_all.jsp?arnumber=6579966). 


Provides functions implementing:

- Koditschek-Rimon Navigation Functions (NF) and their analytic gradients, Hessians
- decentralized Multi-agent NFs
- polynomial NFs
- Khatib potential fields

and a library of implicit representations for:

- halfspaces
- ellipsoids
- tori
- superquadrics
- cylinders
- hyperboloids
- parallelepipeds
- Dupin cyclides
- Booth lemniscates

and:

- principal curvature analysis for some of the above
- local and global diffeomorphisms for [star worlds](http://www.jstor.org/stable/2001835) and [convex worlds](http://ieeexplore.ieee.org/xpls/abs_all.jsp?arnumber=4543782).
- implicit constructive solid geometry (CSG) by implementing [Rvachev functions](https://en.wikipedia.org/wiki/Rvachev_function).

Other features include simultaneous integration of multiple trajectories, functions for fast vectorized plotting and a GUI.

If you use this toolbox, please [cite](http://ieeexplore.ieee.org/xpl/articleDetails.jsp?tp=&arnumber=6579966&queryText%3Dfilippidis+kyriakopoulos) as:

```
@INPROCEEDINGS{Filippidis13acc,
author={Filippidis, I. and Kyriakopoulos, K.J.},
booktitle={American Control Conference (ACC), 2013},
title={Navigation functions for focally admissible surfaces},
year={2013},
pages={994-999},
ISSN={0743-1619},}
```
More details about the theory can be found [here](http://www.cds.caltech.edu/~ifilippi/pubs/2012_filippidis_acc_tr.pdf).

## Installation
Add the directory tree of this package to your MATLAB path.
There are several dependencies from [fex](http://www.mathworks.com/matlabcentral/), which will be released and documented when time permits.
Also my [numerical](https://github.com/johnyf/numerical_utils) and [plotting](https://github.com/johnyf/plot_utils) utilities are needed.
No dependency is OS-dependent.

## About
This package is part of the code I developed during my Diploma thesis at the Control Systems Lab, NTUA.
