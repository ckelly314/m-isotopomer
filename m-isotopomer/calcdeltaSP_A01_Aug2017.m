function deltaVals = calcdeltaSP_A01_Aug2017(isol)

% calcdeltaSP   Calculates delta values in per mil from 15Ralpha, 15Rbeta, 
% 17R and 18R
%=========================================================================
% calcdeltaSP Version 1, Jan 14, 2010
%          
% USAGE:  deltaVals = calcdeltaSP(isol);
%
% DESCRIPTION:
%    Uses values of 15Ralpha, 15Rbeta, 17R and 18R to calculate delta
%    values in per mil notation referenced to AIR (for N) and VSMOW (for
%    O).
%
% INPUT:  isol = array with dimensions n x 4 where n is the number of
%    measurements.  The three columns are 15Ralpha, 15Rbeta, 17R and 18R
%    from left to right.
%
% OUTPUT:
%   deltaVals = array with dimensions n x 6 where n is the number of
%   measurements.  The six columns are d15Nalpha, d15Nbeta, 15N site pref,
%   d15Nbulk, d17O and d18O from left to right.
% 
% AUTHOR:  Cara Manning (manningc@uvic.ca)
%=========================================================================


% Calculate delta values of 15Nalpha and 15Nbeta referenced to AIR
d15NalphaAir = 1000.*(isol(:,1)./0.0036765 - 1);
d15NbetaAir = 1000.*(isol(:,2)./0.0036765 - 1);

% Calculate 15N site preference referenced to AIR
SP = d15NalphaAir - d15NbetaAir;

% Calculate bulk 15N value from site preference values
d15Nbulk = (d15NalphaAir + d15NbetaAir)./2;

% Calculate d17O and d18O referenced to VSMOW
d17O = 1000.*(isol(:,3)./0.0003799 - 1);
d18O = 1000.*(isol(:,4)./0.0020052 - 1);

% Create array of isotope data and return
deltaVals = [d15NalphaAir, d15NbetaAir, SP, d15Nbulk,  d17O, d18O]; 

return