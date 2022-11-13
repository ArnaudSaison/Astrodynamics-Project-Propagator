function [tout,stateout] = propagator(par)
% PROPAGATOR solves the equation of motion
% 
% Inputs: 
%   par = 
%       set of parameters for the propagator, defines what perturbations
%       are taken into account, parameters for the solver, etc
% 
% Ouputs:
%   solution of propagated orbit
% 
% 

disp('Solving ODE...')

% ODE
opts = odeset("RelTol", par.REL_TOL, "AbsTol", par.ABS_TOL, "Stats", par.displ_stats);

tic
switch par.SOLVER
    case {'ODE113'}
        [tout, stateout] = ode113(@(t, y) diffEq(t, y, par), par.tspan, par.ECI0, opts);
    case {'ODE45'}
        [tout, stateout] = ode45(@(t, y) diffEq(t, y, par), par.tspan, par.ECI0, opts);
    otherwise
        error('par.SOLVER specifies unknown MATLAB solver.')
end
toc
