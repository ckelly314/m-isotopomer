function isol = automate_gk_solver(R,ref1,ref2,x0,lb,ub)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate gamma and kappa from measured rR31/30 and r45/44, given known a, b, 17R.
%
% USAGE: gk = automate_gk_solver(R,ref1=ref1, ref2=ref2)
%
% DESCRIPTION:
%   Uses known values of alpha, beta, and 17R for two sample gases and one
%   standard gas, plus measured rR31/30 for sample and standard gases,
%   to calculate scrambling coefficients gamma and kappa.
%
% INPUT:
%   :param R: array with dimensions n x 6 where n is the number of reference pairs.
%   The six columns are 31R, 45R and 46R for reference #1, then 31R, 45R, 46R for reference #2, from left to right.
%   :type R: numpy array, dtype=float
%   :param x0: initial guess for gamma and kappa (e.g. x0=np.array([0.17, 0.08], dtype=float))
%   :type x0: numpy array, dtype=float
%   :param lb: lower bounds for solver (e.g. lb=np.array([0.0, 0.0], dtype=float))
%   :type lb: numpy array, dtype=float
%   :param ub: upper bounds for solver (e.g. ub=np.array([1.0, 1.0], dtype=float))
%   :type ub: numpy array, dtype=float
%
% OUTPUT:
%   :returns: array with dimensions n x 2 where n is the number of measurements.
%   The two columns are gamma and kappa from left to right.
%
% @author: Colette L. Kelly (clkelly@stanford.edu).    
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% initial guess for 15Ralpha and 15Rbeta 
if exist( 'x0', 'var' ) % check if solver has been given a valid x0 parameter
   validateattributes( someInput, { 'double' }, { 'scalar', 'nonnegative' } )
else
   x0 = [0.17; 0.08]; % set default x0
end

% Lower bounds and upper bounds for 15Ralpha and 15Rbeta
% These constraints ensure that the solver converges to a solution in the
% correct range.
if exist( 'lb', 'var' )
   validateattributes( someInput, { 'double' }, { 'scalar', 'nonnegative' } )
else
   lb = [0.1; 0.05];
end

if exist( 'ub', 'var' )
   validateattributes( someInput, { 'double' }, { 'scalar', 'nonnegative' } )
else
   ub = [0.2; 0.2];
end

% Options for solver function
% Include 'Display','iter' to see the solver output for each iteration
% This is helpful if the data output seems suspect
options=optimset('TolFun',1e-10,'TolX',1e-10,'MaxFunEvals',2000); 


% Run least squares nonlinear solver for each row of data
% to obtain 15Ralpha and 15Rbeta
for n = 1:length(R(:,1))
    [v,fval] = lsqnonlin(@automate_gk_eqns,x0,lb,ub,options,R(n,:),ref1,ref2);

    % Create a new array from the iterated solutions 
    % First column is gamma, second is kappa
    isol(n,:) = v; 
end 

return
