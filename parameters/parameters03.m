% -------------------------------------------------------------------------
% PARAMETERS for PART 3
%
% Desciption:
%   Propagates orbit of the ISS for 1 day after TLE. J2 and drag 
%   perturbations.
% -------------------------------------------------------------------------
%
% /!\ No processing should be done in this file as it is done in 'processParam.m'.
% /!\ Always check parameters output in command window at start of program.
% 

% Enable (1) / Disable (0) functionalities
par.ENABLE_J2 = 1;
par.ENABLE_DRAG = 1;

% Intial orbit (based on TLE) (/!\ strings must be between '')
% statement = 1; % 1 = use project statement TLE / 0 = use latest TLE
% 
% if statement
%     par.TLE.L0 = 'ISS (ZARYA)';
%     par.TLE.L1 = '1 25544U 98067A   22290.19422747  .00014688  00000-0  26371-3 0  9990';
%     par.TLE.L2 = '2 25544  51.6432  92.1296 0003569 315.0383 213.8529 15.50120356364100';
% else
%     par.TLE = getLatestTLE('ISS (ZARYA)');
% end

% Intial orbit (based on TLE) (/!\ strings must be between '')
par.BULKTLES_FILENAME = 'bulkISSTLEs';

% Object properties
par.prop.MASS = 410500;         % [kg] mass of object
par.prop.CD = 2.00;             % [-] drag coefficient of the object
par.prop.A = 1641;              % [m^2] object area
par.prop.n = 2;                 % Harris-Priester value for low inclination orbit

% Simulation parameters
par.SOLVER = 'ODE113';          % [str] solver used for propagation can 
                                %       be: ODE45, ODE78, ODE113
par.N_STEP = 1*24*60/2;         % [#] number of step in the simulation
par.T_END = 1*24*3600;          % [s] number of seconds in the simulation
par.REL_TOL = 1e-10;            % [-] relative tolerance
par.ABS_TOL = 1e-10;            % [-] absolute tolerance

% Dev options
par.DEBUG = 1;                  % additional information during execution

% Representation options
par.PRINT_PDF = 1;              % prints figures to PDF in the figures folder
par.PDF_FOLDER = 'figures/3_';  % folder in which PDF figures are saved
