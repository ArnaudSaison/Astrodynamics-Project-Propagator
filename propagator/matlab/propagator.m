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

% ODE
opts = odeset("RelTol", par.REL_TOL, "AbsTol", par.ABS_TOL, "Stats", par.displ_stats);

tic
[tout, stateout] = ode113(@(t, y) diffEq(t, y, par), par.tspan, par.ECI0, opts);
toc
