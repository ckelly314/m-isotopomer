% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File: N2OSPcalcs.m
% -----------------------------
% Created on Weds April 14th, 2021
%
% Example script showing how to use isotopomer scripts.
%
% @author: Cara Manning (cama@pml.ac.uk) and Colette Kelly
% (clkelly@stanford.edu)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%
% USER INPUTS %
%%%%%%%%%%%%%%%

% USER INPUT: Input data used to solve equation.
% Columns are 31R, 45R and 46R (x, y and z) from left to right.
% Each row is the data for one sample.
% Input data should include at least six significant figures for accurate 
% results.
inputfilename = 'example_input.csv';

% USER INPUT: isotopomers output filename
% Create a commma delimited file containing the isotope data
% The columns from left to right are: 
% d15Nalpha, d15Nbeta, 15N site pref, d15Nbulk,  d17O, d18O
outputfilename = 'example_output.txt';

% USER INPUT: scrambling coefficients
% These are calculated with the package of scrambling scripts:
% automate_gk_setinputs.m, automate_gk_solver.m, automate_gk_eqns.m, and
% constants.m
gamma_kappa = [0.171 0.079];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RUN SOLVER - NO NEED TO MODIFY BELOW THIS LINE %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% read in data
R = load(inputfilename);

% Run function that iteratively solves for 15Ralpha and 15Rbeta (a and b) 
% and then calculates 17R and 18R (c and d) by substitution
isol = calcSPmain_Aug2017(R, gamma_kappa);

% Run function that converts the data above to per mil notation referenced
% to AIR (for N) and VSMOW (for O).
deltaVals = calcdeltaSP_A01_Aug2017(isol);

% Create a commma delimited text file containing the isotope data
% 'precision', 8 saves each value to 8 decimal places instead of the
% default 6
dlmwrite(outputfilename, deltaVals, 'delimiter', '\t', 'precision', 8)
