function isol = calcSPmain_Aug2017(R, scrambling)

% calcSPmain   Calculates 15Ralpha, 15R beta, 17R and 18R
%=========================================================================
% calcSPmain Version 1, Jan 14, 2010
%          
% USAGE:  isol = calcSPmain(R)
%
% DESCRIPTION:
%    Uses values of 31R, 45R and 46R to calculate 15Ralpha, 15R beta, 17R
%    and 18R
%
% INPUT:  R = array with dimensions n x 3 where n is the number of
%   measurements.  The three columns are 31R, 45R and 46R from left to 
%   right.
%
% OUTPUT:
%   isol = array with dimensions n x 4 where n is the number of
%   measurements.  The four columns are 15Ralpha, 15Rbeta, 17R and 18R from
%   left to right.
% 
% AUTHOR:  Cara Manning (manningc@uvic.ca)
%=========================================================================


% initial guess for 15Ralpha and 15Rbeta 
x0 = [0.0037; 0.0037];

% Lower bounds and upper bounds for 15Ralpha and 15Rbeta
% These constraints ensure that the solver converges to a solution in the
% correct range.
lb = [0.003; 0.003]; ub = [0.005; 0.005];

% Options for solver function
% Include 'Display','iter' to see the solver output for each iteration
% This is helpful if the data output seems suspect
options=optimset('TolFun',1e-20,'TolX',1e-20,'MaxFunEvals',2000); 


% Run least squares nonlinear solver for each row of data
% to obtain 15Ralpha and 15Rbeta
for n = 1:length(R(:,1))
    [v,fval] = lsqnonlin(@SPnonlineq_Aug2017,x0,lb,ub,options,R(n,:),scrambling);

    % Create a new array from the iterated solutions 
    % First column is 15Ralpha, second is 15Rbeta
    isol(n,:) = v; 
end 

% Calculate 17R (c) for the third column of isol
isol(:,3) = R(:,2) - isol(:,1) - isol(:,2);

% Calculate 18R (d) for the fourth column of isol
isol(:,4) = 0.0020052.*(isol(:,3)./0.0003799).^(1/0.516);

return