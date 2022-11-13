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
% Authors: Antoine Montuzet, Arnaud Saison
% Academic Year: 2022-2023
% Course: AERO0024-1 Astrodynamics
%
% -------------------------------------------------------------------------
% Description: 
%   "The objective of this project is the development of an orbital
%   propagator in the Matlab environment. This propagator should provide a
%   realistic approxi- mation of spacecraft trajectories around the Earth.
%   Eventually, the predictions of your propagator should be compared
%   against the real trajectory of a satellite in low Earth orbit."
% 
% User Manual: Please see README.md
%
% Minimum requirements: 
%   - Aerospace Toolbox
% 
% Structure:
%   propagator/
%       matlab/
%           diffEq.m            differential equation
%           plot_3D.m           represents solution in 3D
%           processParam.m      processes and groups parameters
%           propagator.m        solves the equation of motion
%       python/
%   utils/
%       fig2pdf.m               converts figure to pdf
% 
% =========================================================================

%% Setting up path
clc; close all; clear;          % cleaning up
restoredefaultpath              % restores path
addpath('./data/', './propagator/matlab/', './utils/', './parameters/', './figures/');

%% Parameters
PARAMETERS_FILE = 'parameters01.m';
run(PARAMETERS_FILE);           % user parameters (generates structure named 'par')

%% Propagating
[time, ECI] = propagator(par);

%% Representing and converting to non-inertial frames
[ECEF, fig_ax] = plotOrbit(par, time, ECI);

% finding lla (latitude longitude altitude)
% /!\ S3L ouputs altitude longitude latitude
LLA = ecef2lla(ECEF);


