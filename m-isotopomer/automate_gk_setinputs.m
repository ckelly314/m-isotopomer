% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File: automate_gk_setinputs.m
% -----------------------------
% Created on Weds April 14th, 2021
%
% Example script showing how to use scrambling solver.
%
% @author: Colette L. Kelly (clkelly@stanford.edu).
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%
% USER INPUTS %
%%%%%%%%%%%%%%%

% USER INPUT: Input data used to solve equation.
% Columns are 31R, 45R and 46R for ref. #1, then 31R, 45R and 46R for ref. #2,
% from left to right.
% Each row is the data for one reference material pairing.
% Input data should include at least six significant figures for accurate 
% results.
inputfilename = 'example_atm_s2.csv';

% USER INPUT: scrambling output filename
% columns are gamma, kappa from left to right
% Each row is the data for one reference material pairing.
outputfilename = 'example_atm_s2_output.txt';

% USER INPUT: two reference materials used to calculate scrambling
% make sure these have been added to constants.m
ref1 = 'ATM';
ref2 = 'S2';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RUN SOLVER - NO NEED TO MODIFY BELOW THIS LINE %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% read in data
R = load(inputfilename);

% Run function that iteratively solves for gamma and kappa
gk = automate_gk_solver(R,ref1,ref2);

% Create a commma delimited text file containing the output data
% The columns from left to right are gamma and kappa
dlmwrite(outputfilename, gk, 'delimiter', '\t', 'precision', 8)

