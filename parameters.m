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
par.ENABLE_J2 = 1;
par.ENABLE_DRAG = 1;

% Intial orbit (based on TLE) (/!\ strings must be between '')
par.TLE.L0 = 'ISS (ZARYA)';
par.TLE.L1 = '1 25544U 98067A   22290.19422747  .00014688  00000-0  26371-3 0  9990';
par.TLE.L2 = '2 25544  51.6432  92.1296 0003569 315.0383 213.8529 15.50120356364100';

% par.TLE.L0 = 'ISS (ZARYA)             ';
% par.TLE.L1 = '1 25544U 98067A   22307.39895310  .00017310  00000-0  31368-3 0  9998';
% par.TLE.L2 = '2 25544  51.6453   6.9445 0006467  35.6599  53.8579 15.49704861366775';

% Object properties
par.prop.MASS = 410500;         % [kg] mass of object
par.prop.CD = 2.00;             % [-] drag coefficient of the object
par.prop.A = 1641;              % [m^2] object area

% Simulation parameters
par.N_STEP = 5000;              % [#] number of step in the simulation
par.T_END = 1*24*3600;          % [s] number of seconds in the simulation
par.REL_TOL = 1e-13;            % [?] relative tolerance
par.ABS_TOL = 1e-15;            % [?] absolute tolerance

% Dev options
par.DEBUG = 1;

% Representation options
par.PLOT_BOTH_TRACKS = 1;

end