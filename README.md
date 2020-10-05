# plaque_growth_pdes
Code for solving the partial differential equations describing plaque growth using matlab.

This contains the different bits of code that are required to solve the reaction-diffusion equations describing plaque growth. 
There are variants with uniform phage diffusion rate (UDMs) and variants with variable phage diffusion rate (VDMs), where the diffusion rate 
varies due to steric interactions with host cells. There are also variants where adsorption to already infected hosts 
does (+) and does not (-) occur.

To run the solver you need 5 files. Briefly, the files are:
1. Name3_Solver.m - This is the code that you should actually run to run the solver
2. Name3.m - Defines the system of equations to be solved
3. variable3bc.m - Defines boundary conditions of problem
4. variable3ic.m - Defines initial conditions of problem
5. asymptotefcn.m - Defines the function used to determine the asymptotic velocity of the expansion

"Name" in 1 and 2 changes depending on the model variant:
UDM+ = "ConstantD"
UDM- = "Jones"
VDM+ = "Full"
VDM- = "noIads"

To run the solver the file Name3_Solver.m should be run. In the case of UDMs this takes 2 input arguments: "name" being the name of the output file where the results 
should be saved, and Ktemp being the K parameter value for which the solution should be determined. In the case of the VDMs there are 2 additional inputs: Ltemp and 
alphatemp corresponding to the lysis time and adsorption rate. This is equivalent to providing f and Kmax, assuming a fixed Bmax, but is written this way simply as 
a hangover from earlier iterations of the code.

Running the code successfully should result in a output file name.mat that contains the population profiles as a function of time and space, along with the results such as the 
asymptotic velocity of the front etc. 

In the case where the solver fails prematurely or there are numerical instabilities or something like that the profiles should still be saved, and the 
velocity etc can be calculated from the profiles using the Data_Fixer.mlx script that plots the profiles and velocity as a function of space/time, and 
allows you to define a specific range of data to use when computing the asymptotic velocity. This is slightly difficult to explain so I have included some "good" 
and some "bad" example data that you can run through the fixer to illustrate what I mean.
