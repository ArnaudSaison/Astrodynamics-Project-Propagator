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
% PART 4
% Comparison with the trajectory of a satellite of your choice.
%
%
% Authors: Antoine Montuzet, Arnaud Saison
% Academic Year: 2022-2023
% Course: AERO0024-1 Astrodynamics
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


%% Parameters
PARAMETERS_FILE = 'parameters02';
run([PARAMETERS_FILE, '.m']);   % user parameters (generates structure named 'par')

% processing parameters
par = processParam(par);
dispParam(par);

par.PDF_FOLDER = 'figures/uncertainty_';


%% Propagating
% base
[time, ECI] = propagator(par);
[ECEF, LLA, OE, time_vec] = ECI2ECEF2LLA2OE(ECI, time, par); % conversion

% Upper bound
par.pdata.earth.mu = par.pdata.earth.mu + 8e5;
[time_u, ECI_u] = propagator(par);
[ECEF_u, LLA_u, OE_u, time_vec_u] = ECI2ECEF2LLA2OE(ECI_u, time_u, par); % conversion

% Lower bound
par.pdata.earth.mu = par.pdata.earth.mu - 2 * 8e5;
[time_l, ECI_l] = propagator(par);
[ECEF_l, LLA_l, OE_l, time_vec_l] = ECI2ECEF2LLA2OE(ECI_l, time_l, par); % conversion


%% Comparing
diff_abs_eci_u = ECI_u - ECI;
diff_abs_eci_l = ECI_l - ECI;

figure('Name', 'Error bars in ECI', 'WindowStyle', 'docked')

plot(datetime(time_vec_u), vecnorm(diff_abs_eci_u, 2, 2), ...
     'DisplayName', '\mu + 8e5 m^3.s^{-2}'); hold on;
plot(datetime(time_vec_l), vecnorm(diff_abs_eci_l, 2, 2), ...
     'DisplayName', '\mu - 8e5 m^3.s^{-2}'); hold on;

grid on
ylabel('Distance difference [m]')
xlabel('Time')
legend('Location','northwest')
xtickangle(90);
xticksCustomDate();

if par.PRINT_PDF, fig2pdf(gcf, 'error_bars_ECI', 1.5, 1.5, par.PDF_FOLDER); end


