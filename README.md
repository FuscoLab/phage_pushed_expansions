# Virus-host interactions shape viral dispersal giving rise to distinct classes of travelling waves in spatial expansions
Codes and Figures for "Virus-host interactions shape viral dispersal giving rise to distinct classes of travelling waves in spatial expansions" by Michael Hunter, Nikhil Krishnan, Tongfei Liu, Wolfram Möbius,  and Diana Fusco


- [bioXiv preprint](https://www.biorxiv.org/content/10.1101/2020.09.23.310201v3)
## Sections:

- [Abstract](#abstract)
- [Plaque-growth PDEs](#Plaque-growth-PDEs)
- [Stochastic simulations of heterozygosity decay](#stochastic-simulations-of-heterozygosity-decay)

## Abstract

Reaction-diffusion waves have long been used to describe the growth and spread of populations undergoing a spatial range expansion. Such waves are generally classed as either pulled, where the dynamics are driven by the very tip of the front and stochastic fluctuations are high, or pushed, where cooperation in growth or dispersal results in a bulk-driven wave in which fluctuations are suppressed. These concepts have been well studied experimentally in populations where the cooperation leads to a density-dependent growth rate. By contrast, relatively little is known about experimental populations that exhibit density-dependent dispersal.

Using bacteriophage T7 as a test organism, we present novel experimental measurements that demonstrate that the diffusion of phage T7, in a lawn of host E. coli, is hindered by steric interactions with host bacteria cells. The coupling between host density, phage dispersal and cell lysis caused by viral infection results in an effective density-dependent diffusion coefficient akin to cooperative behavior. Using a system of reaction-diffusion equations, we show that this effect can result in a transition from a pulled to pushed expansion. Moreover, we find that a second, independent density-dependent effect on phage dispersal spontaneously emerges as a result of the viral incubation period, during which phage is trapped inside the host unable to disperse. Additional stochastic agent-based simulations reveal that lysis time dramatically affects the rate of diversity loss in viral expansions. Taken together, our results indicate both that bacteriophage can be used as a controllable laboratory population to investigate the impact of density-dependent dispersal on evolution, and that the genetic diversity and adaptability of expanding viral populations could be much greater than is currently assumed.

## Plaque growth PDES

Code for solving the partial differential equations describing plaque growth using matlab in `PDE_Codes` directory.

This contains the different bits of code that are required to solve the reaction-diffusion equations describing plaque growth. 
There are variants with uniform phage diffusion rate (UDMs) and variants with variable phage diffusion rate (VDMs), where the diffusion rate 
varies due to steric interactions with host cells. There are also variants where adsorption to already infected hosts 
does (+) and does not (-) occur.

To run the solver you need 5 files. Briefly, the files are:
1. `Name3_Solver.m `- This is the code that you should actually run to run the solver
2. `Name3.m` - Defines the system of equations to be solved
3. `variable3bc.m` - Defines boundary conditions of problem
4. `variable3ic.m` - Defines initial conditions of problem
5. `asymptotefcn.m` - Defines the function used to determine the asymptotic velocity of the expansion

"Name" in 1 and 2 changes depending on the model variant:
UDM+ = "ConstantD"
UDM- = "Jones"
VDM+ = "Full"
VDM- = "noIads"

To run the solver the file `Name3_Solver.m` should be run. In the case of UDMs this takes 2 input arguments: "name" being the name of the output file where the results 
should be saved, and Ktemp being the K parameter value for which the solution should be determined. In the case of the VDMs there are 2 additional inputs: `Ltemp` and 
`alphatemp` corresponding to the lysis time and adsorption rate. This is equivalent to providing `f` and `Kmax,` assuming a fixed `Bmax`, but is written this way simply as 
a hangover from earlier iterations of the code.

Running the code successfully should result in a output file name.mat that contains the population profiles as a function of time and space, along with the results such as the 
asymptotic velocity of the front etc. 

In the case where the solver fails prematurely or there are numerical instabilities or something like that the profiles should still be saved, and the 
velocity etc can be calculated from the profiles using the `Data_Fixer.mlx` script that plots the profiles and velocity as a function of space/time, and 
allows you to define a specific range of data to use when computing the asymptotic velocity. This is slightly difficult to explain so I have included some "good" 
and some "bad" example data that you can run through the fixer to illustrate what I mean.


## Stochastic simulations of heterozygosity decay

The main script for simulating heterozygosity decay during phage expansions is `phage_inf_coarse_het.cpp` in the `SDE_codes` directory. This script simulates the process of phage absortion dispersal and lysis over a lawn of bacteria in 1 dimension. There is no spatial limit on the simulation as a co-moving simulation box is implemented. Requirements for use are a C++ compilter supporting the C++11 standard. The program can called from the command line as follows

```bash
g++ -o phage_sim phage_inf_coarse_het.cpp -lgsl
./phage_sim
```

which will run the script with the default parameters. the `-lgsl` flag may or may not be necessary depending on your machines configuration. Additional flags on the compiled program can be used to specify parameters such as,`./phage_sim -a .005 -t 200`, which would run the program with alpha B0 = .005 and tau = 200. See Methods section of paper and script documentation for more details. Simulations were performed on the Cambridge Service for Data Driven Discovery (CSD3) operated by the University of Cambridge Research Computing Service, which uses the slurm scheduling manager. A sample python script to generate slurm scripts is included in the directory, `make_het_sde_slurm.py`

A python notebook `Heterozygosity decay SDE analysis.ipynb` is included in the directory which goes through the analysis of heterozygosity decay rate and reproduces the relevant figures included in the paper (Fig.6 and Fig. 16). Data used in the notebook is included in the `SDE_codes/data` directory.
