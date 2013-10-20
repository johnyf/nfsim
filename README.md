NAVIGATION FUNCTION SIMULATION TOOLBOX FOR MATLAB
-------------------------------------------------
Version 0.2
2011 March

AUTHOR
------
by Ioannis Filippidis

CONTACT
-------
jfilippidis@gmail.com | http://users.ntua.gr/mc06009/
Control Systems Lab, National Technical University of Athens, Greece | http://www.csl.ntua.gr

ABOUT
-----
This is a MATLAB toolbox for simulating agent navigation using artificial potential fields.
It offers a library of functions and a GUI.

INSTALL
-------
The tarball archive contains a directory named "nfsim".
Extract this directory and place it in a location of your choice in your file system.
Open MATLAB. At the Command Window issue the command "pathtool".
A window opens. Choose "Add with subfolders", navigate to where you placed directory "nfsim".
Select the "nfsim" directory and press OK. Then press SAVE, after that press CLOSE.

Alternatively you can add just the "nfsim" directory to your path and
then run the script "installnfsim" at the MATLAB Command Window.
This will check whether the toolbox directory structure is correctly added
to the MATLAB path. If not, it will add all the Toolbox directories to the
MATLAB path. Then it will open the Navigation Function Simulation GUI.

HELP
----
1: For detailed instructions on usage of the Software see:
        Ioannis Filippidis, Adaptive Navigation Functions, BSc Thesis,
        Department of Mechanical Engineering, National Technical University of Athens, Greece.
        http://dspace.lib.ntua.gr
	
2: At the MATLAB Command Window type:
        help functionName
        for any of function named "functionName" to see the help comments within its file "functionName.m".

3: To access the HTML documentation open the MATLAB Help Browser and
        go to the "Navigation Function Toolbox" entry in the Contents Pane.
        Note that after version R2008 MATLAB does not support the doc command for Toolboxes other
        than those created by The MathWorks. So the command
	doc functionName
	will NOT show the provided HTML documentation in the MATLAB Help Browser.

COMPATIBILITY
-------------
This package requires MATLAB Version R2010b (or higher) to work.
It uses the following MATLAB Toolboxes
It runs on any platform supported by MATLAB, no platform-dependent features are included.
Files from the MathWorks File Exchange are also used and included in the directory
named "central".

UNINSTALL
---------
To remove the Toolbox from your computer, after properly installing it
issue the following command in the MATLAB Command Window:
startnfsim(-1)
which will remove all the toolbox paths from your MATLAB path.
Then you can delete the "nfsim" directory.

LICENSE
-------
For Copyright information see the LICENSE file.
Personal use for educational use is allowed.
If the Toolbox is used to publish citation is required.
For professional use or access to the source code,
users should contact the author directly.

The files provided in directory "central" are from the
MathWorks file exchange and remain under their respective Copyright
conditions. They are used by the toolbox and are distributed
with it for convenience.

MATLAB is a Registered Trademark of The MathWorks, Inc.

CITATION
--------
To cite the toolbox
@THESIS{Filippidis11,
	AUTHOR             = {Ioannis F. Filippidis},
	TITLE              = {Adaptive Formulation of Navigation Functions for Unknown Sphere Worlds},
	SCHOOL             = {Department of Mechanical Engineering, National Technical University of Athens},
        ADDRESS    =       = {Greece},
	YEAR               = {2011}
}
