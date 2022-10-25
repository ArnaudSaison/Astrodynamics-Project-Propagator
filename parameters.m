function par = parameters()
% PARAMETERS user set parameters (no processing)
%   No processing should be done in this file as it is done
%   'processParam.m'. This allows 
% 
% Inputs: -
% 
% Ouputs:
%   par = structure containing parameters
% 

% Enable (1) / Disable (0) functionalities
% - J2: enables the J2 perturbation
% - drag: enables drag
par.J2 = 1;
par.DRAG = 0;

% Intial orbit (based on TLE) (/!\ strings must be between '')
par.TLE.L0 = 'ISS (ZARYA)';
par.TLE.L1 = '1 25544U 98067A   22298.70251956  .00092330  00000+0  16374-2 0  9997';
par.TLE.L2 = '2 25544  51.6431  50.0017 0005670   3.9708 141.4403 15.49452998365423';

% Object properties
par.prop.MASS = 410500;         % [kg] mass of object
par.prop.CD = 2.00;             % [-] drag coefficient of the object
par.prop.A = 1641;              % [m^2] object area

% Simulation parameters
par.N_STEP = 1000;              % [#] number of step in the simulation
par.T_END = 1*24*3600;          % [s] number of seconds in the simulation
par.REL_TOL = 1e-13;            % [?] relative tolerance
par.ABS_TOL = 1e-15;            % [?] absolute tolerance

% Dev options
par.DEBUG = 1;

end