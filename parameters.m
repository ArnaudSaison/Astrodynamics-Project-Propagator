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

% Intial orbit (based on TLE)
par.TLE0 = "ISS (ZARYA)";
par.TLE1 = "1 25544U 98067A 22290.19422747 .00014688 00000-0 26371-3 0 9990";
par.TLE2 = "2 25544 51.6432 92.1296 0003569 315.0383 213.8529 15.50120356364100";

% Object properties
par.prop.MASS = 410500;         % [kg] mass of object
par.prop.CD = 2.00;             % [-] drag coefficient of the object
par.prop.A = 1641;              % [m^2] object area

% Simulation parameters
par.N_STEP = 1000;              % [#] number of step in the simulation
par.T_END = 1*24*3600;          % [s] number of seconds in the simulation
par.REL_TOL = 1e-13;            % [?] relative tolerance
par.ABS_TOL = 1e-15;            % [?] absolute tolerance
par.DISPL_STATS = "on";         % [str] display statistics when solving

end