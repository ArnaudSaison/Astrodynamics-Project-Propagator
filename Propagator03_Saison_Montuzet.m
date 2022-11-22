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
% PART 3
% atmospheric drag
%
%
% Authors: Antoine Montuzet, Arnaud Saison
% Academic Year: 2022-2023
% Course: AERO0024-1 Astrodynamics
%
% =========================================================================

%% Setting up path
clc; close all; clear;          % cleaning up
restoredefaultpath              % restores path
addpath('./data/', './propagator/matlab/', './utils/', './parameters/', './figures/');


%% Parameters
PARAMETERS_FILE = 'parameters03';
run([PARAMETERS_FILE, '.m']);   % user parameters (generates structure named 'par')

% processing parameters
par = processParam(par);
dispParam(par);


%% Propagating
[time, ECI] = propagator(par);


%% Question 1.3: S3L propagator
restoredefaultpath; % changing path to avoid naming conflicts
addpath(genpath('./S3Lprop_v1_21'));

warning off; % removing annoying warnings

[S3L.t, S3L.oe, S3L.par, S3L.cartesian, S3L.geodetic] = ...
    orbprop([par.Orb_elem0.a, ...
             par.Orb_elem0.ecc, ...
             par.Orb_elem0.i, ...
             par.Orb_elem0.omega, ...
             par.Orb_elem0.RAAN, ...
             par.Orb_elem0.theta], ...
            'time', par.T_END, ...
            'dt', par.T_END / (par.N_STEP - 1), ...
            'fmodel', [par.ENABLE_J2, ...       % grav
                       par.ENABLE_DRAG, ...     % drag
                       0, ...                   % SRP
                       0, ...                   % 3rd-body sun
                       0], ...                  % 3rd-body moon
            'Ngrav', 2, 'Mgrav', 0, ...
            'plot', [1, ...                     % groundrtack
                     1, ...                     % 3D
                     0, ...                     % groundtrack 3D
                     1, ...                     % keplerian
                     0, ...                     % elem
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
            'Cd', par.prop.CD, ...
            'm',  par.prop.MASS, ...
            'Sd', par.prop.A, ...
            'nHP', 2, ...
            'density', 1);

warning on;


%% Resetting path
restoredefaultpath              % restores path
addpath('./data/', './propagator/matlab/', './utils/', './parameters/', './figures/');


%% Representing and converting to non-inertial frames
if par.PLOT_BOTH_TRACKS
    [ECEF, LLA, fig_ax] = plotOrbit(par, time, ECI, S3L.cartesian);
else
    [ECEF, LLA, fig_ax] = plotOrbit(par, time, ECI);
end


%% Comparing
errorComparison(par, time, ECI, LLA, S3L.cartesian, S3L.geodetic)






