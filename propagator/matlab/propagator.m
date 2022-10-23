function [tout,stateout] = propagator(par)
% PROPAGATOR solves the equation of motion
% 
% Inputs: 
%   par = 
%       set of parameters for the propagator, defines what perturbations
%       are taken into account
% 
% Ouputs:
%   solution of propagated orbit
% 
% 

r_mag = par.pdata.earth.radius + 414e3;
v_mag = sqrt(par.pdata.earth.mu/r_mag);

% initial position and velocity vector
r0 = [r_mag,0,0];
v0 = [0, v_mag-1,4];

% Array
state0 = [r0, v0];

% ODE
opts = odeset("RelTol", par.REL_TOL, "AbsTol", par.ABS_TOL, "Stats", par.DISPL_STATS);

tic
[tout, stateout] = ode78(@(t, y) diffEq(t, y, par.pdata.earth.mu), par.tspan, state0, opts);
toc

end