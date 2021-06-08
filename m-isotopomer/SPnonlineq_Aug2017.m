function F = SPnonlineq_Aug2017(f,R,scrambling)

% SPnonlineq   Calculates 15Ralpha and 15Rbeta from 31R, 45R and 46R
%=========================================================================
% SPnonlineq Version 1, Jan 14, 2010
%          
% USAGE:  [v,fval] = lsqnonlin(@SPnonlineq,x0,lb,ub,options,R(n,:));
%    Please see calcSPmain.m for definitions of these variables.
%
% DESCRIPTION:
%    Uses values of 31R, 45R and 46R to iteratively solve for 15Ralpha and 
%    15R beta
%
% INPUT:  R = array with dimensions n x 3 where n is the number of
%    measurements.  The three columns are 31R, 45R and 46R from left to 
%    right.
%
% OUTPUT:
%   F = array with dimensions n x 2 where n is the number of
%   measurements.  The two columns are 15Ralpha and 15Rbeta from left to 
%   right.
% 
% AUTHOR:  Cara Manning (manningc@uvic.ca)
%=========================================================================

% rename inputted data
x = R(:,1);
y = R(:,2);
z = R(:,3);

% pull scrambling coefficients
g = scrambling(1);
k = scrambling(2);

% solve two equations with two unknowns
% f(1) = 15Ralpha = a, and f(2) = 15Rbeta = b
F = [(f(1) + f(2)).*(y - f(1) - f(2)) + (0.0020052).*((y - f(1) - f(2))./0.0003799).^(1/0.516) + f(1).*f(2) - z;
    (1-g).*f(1) + k.*f(2) + f(1).*f(2) + (y - f(1) - f(2)).*(1 + g*f(1) + (1-k).*f(2)) - x*(1 + g.*f(1) + (1-k).*f(2))];

return

