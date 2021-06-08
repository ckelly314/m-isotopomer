function [a, b, a2, b2] = constants(ref1, ref2)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Return 15Ralpha and 15Rbeta for the two reference materials used to
% calibrate scrambling.
%
% USAGE: a, b, a2, b2 = constants('ATM', 'S2')
%
% INPUT:
%   :param ref1: name of first reference material used for scrambling calibration
%   :type ref1: string
%   :param ref2: name of second reference material used for scrambling calibration
%   :type ref2: string
%
% OUTPUT:
%   :returns: 15Ralpha %1, 15Rbeta %1, 15Ralpha %2, 15Rbeta %2
%
% @author: Colette L. Kelly (clkelly@stanford.edu).
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%
% USER INPUTS %
%%%%%%%%%%%%%%%

% Ensure this dictionary contains both ref. materials used for the calibration
% to be used for the scrambling calibration
% If it does not, add data in this format:
% c('REFNAME') = [15Ralpha 15Rbeta];
c = containers.Map;
c('ATM') = [0.003734221050 0.003664367550]; % atmosphere-equilibrated seawater
c('S2') = [0.003696905 0.003629183]; % Toyoda Lab S2
c('B6') = [0.00367501482137193 0.00367595533009498]; % Air Liquide B6
c('S1') = [0.00373422105 0.003664698435]; % Toyoda Lab S1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ACCESS VALUES - NO NEED TO MODIFY BELOW THIS LINE %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ref1 = c(ref1);
a = ref1(1); b = ref1(2);

ref2 = c(ref2);
a2 = ref2(1); b2 = ref2(2);

return