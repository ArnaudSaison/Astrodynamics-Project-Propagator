% =========================================================================
%
% ______                                 .-._   _ _ _ _ _ _ _ _
% | ___ \                     .-''-.__.-'00  '-' ' ' ' ' ' ' ' '-.
% | |_/ / __ ___  _ __   __ _ '.___ '    .   .--_'-' '-' '-' _'-' '._
% |  __/ '__/ _ \| '_ \ / _` | V: V 'vv-'   '_   '.       .'  _..' '.'.
% | |  | | | (_) | |_) | (_| |   '=.____.=_.--'   :_.__.__:_   '.   : :
% \_|  |_|  \___/| .__/ \__,_|           (((____.-'        '-.  /   : :
%                | |                                       (((-'\ .' /
%                |_|                                     _____..'  .'
%                                                       '-._____.-'
%
% =========================================================================
% A two body propagator
%
% PART 2
% J2 perturbation
%
%
% Authors: Antoine Montuzet, Arnaud Saison
% Academic Year: 2022-2023
% Course: AERO0024-1 Astrodynamics
%
% User guide: Please see README.md
%
% =========================================================================

%% Setting up path
% /!\ WARNING: The S3L files should be placed in a folder in the root
% folder of the project. Doing otherwise will cause naming conflicts.
clc; close all; clear;          % cleaning up

path.gator = char(join({'./data', './propagator/matlab', './utils', './parameters', './figures'}, ';'));
path.S3L = genpath('./S3Lprop_v1_21');

restoredefaultpath              % restores path
addpath(path.gator);            % sets path

set(0,'defaultAxesFontSize', 16)


%% Parameters
PARAMETERS_FILE = 'parameters02';
run([PARAMETERS_FILE, '.m']);   % user parameters (generates structure named 'par')

% processing parameters
par = processParam(par);
dispParam(par);


%% Propagating
[time, ECI] = propagator(par);

% conversions
[ECEF, LLA, OE, time_vec] = ECI2ECEF2LLA2OE(ECI, time, par);


%% Question 2.2: S3L propagator
restoredefaultpath; % changing path to avoid naming conflicts
addpath(path.S3L);

warning off; % removing annoying warnings
if par.DEBUG
    disp('Running the S3L propagator...')
end

[S3L.t, S3L.oe, S3L.par, S3L.cartesian, S3L.geodetic] = ...
    orbprop([par.Orb_elem0.a, ...
             par.Orb_elem0.ecc, ...
             par.Orb_elem0.i, ...
             par.Orb_elem0.omega, ...
             par.Orb_elem0.RAAN, ...
             par.Orb_elem0.theta], ...
            'time', par.T_END, ...
            'dt', par.T_END / par.N_STEP, ...
            'fmodel', [par.ENABLE_J2, ...       % grav
                       par.ENABLE_DRAG, ...     % drag
                       0, ...                   % SRP
                       0, ...                   % 3rd-body sun
                       0], ...                  % 3rd-body moon
            'Ngrav', 2, 'Mgrav', 0, ...
            'plot', [1, ...                     % groundrtack
                     1, ...                     % 3D
                     1, ...                     % groundtrack 3D
                     1, ...                     % keplerian
                     1, ...                     % elem
                     1], ...                    % altitude
            'YYYY', par.Orb_elem0.utc_vec(1), ...
            'MM', par.Orb_elem0.utc_vec(2), ...
            'DD', par.Orb_elem0.utc_vec(3), ...
            'hh', par.Orb_elem0.utc_vec(4), ...
            'mm', par.Orb_elem0.utc_vec(5), ...
            'ss', par.Orb_elem0.utc_vec(6), ...
            'waitbar', 0, ...
            'RelTol', par.REL_TOL, ...
            'AbsTol', par.ABS_TOL, ...
            'ecef', [1, 1, 1, 0], ...
            'ODE113', 1);

warning on;

S3L.geodetic(:,1:3) = S3L.geodetic(:,flip(1:3)); % S3L uses alt-lat-long which is not standard


%% Resetting path
restoredefaultpath              % restores path
addpath(path.gator);

% conversions
S3L.ECI = S3L.cartesian;
S3L.time = S3L.t;
[S3L.ECEF, S3L.LLA, S3L.OE, S3L.time_vec] = ECI2ECEF2LLA2OE(S3L.ECI, S3L.time, par);


%% Question 2.3: propagated ISS position after 24h
dispLine('=');
disp(['<strong>Keplerian Elements after ', num2str(par.T_END /24/3600, '%.2f'), ' day(s) </strong>'])
dispKeplerian(OE.i(end), OE.RAAN(end), OE.ecc(end), OE.omega(end), OE.theta(end), OE.a(end));
dispLine('=');


%% Question 2.4: Analytical formulas (deg/day)
AN = anaOblPertu(par);


%% Question -: Representing orbit
[fig_ax] = plotOrbit(par, time, time_vec, ECI, ECEF, OE, LLA, AN);


%% Comparing
errorComparison(par, time, time_vec, ECI, LLA, S3L.ECI, S3L.LLA);

