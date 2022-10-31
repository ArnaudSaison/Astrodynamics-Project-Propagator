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
% PART 1
% Two-body problem 
%
%
% Authors: Antoine Montuzet, Arnaud Saison
% Academic Year: 2022-2023
% Course: AERO0024-1 Astrodynamics
%
% =========================================================================

%% Setting up path
restoredefaultpath
addpath(genpath('.'));      % setting up path
clc; close all; clear;      % cleaning up

%% Parameters
par = parameters();         % user parameters

% modifications to parameters for PART 1 (no perturbations)
par.ENABLE_J2 = 0;
par.ENABLE_DRAG = 0;

par.N_STEP = 1000;              % [#] number of step in the simulation
par.T_END = 1*24*3600;          % [s] number of seconds in the simulation

% processing parameters
par = processParam(par);
dispParam(par);

%% Propagating
[time, ECI] = propagator(par);

%% Representing
ECEF = plotOrbit(par, time, ECI);

%% Question 1.3
[S3L.t, S3L.oe, S3L.par, S3L.cartesian, S3L.geodetic] = ...
    orbprop([par.Orb_elem0.a, ...
             par.Orb_elem0.ecc, ...
             par.Orb_elem0.i, ...
             par.Orb_elem0.omega, ...
             par.Orb_elem0.RAAN, ...
             ], ...
            'time', , ...
            'dt', , ...)






