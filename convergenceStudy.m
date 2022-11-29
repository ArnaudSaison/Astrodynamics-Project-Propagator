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
% VALIDATION
% Convergence Analysis
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
PARAMETERS_FILE = 'parameters01'; % WARNING: code takes around 40 minutes to run with J2 perturbation
run([PARAMETERS_FILE, '.m']);   % user parameters (generates structure named 'par')

% Convergence analysis paremeters
nb_conv_analy = 9;
REL_TOL_min = -4;
REL_TOL_max = -12;
ABS_TOL_min = REL_TOL_min;
ABS_TOL_max = REL_TOL_max;

par.REL_TOL_vec = logspace(REL_TOL_min, REL_TOL_max, nb_conv_analy);
par.ABS_TOL_vec = logspace(ABS_TOL_min, ABS_TOL_max, nb_conv_analy);

par.SOLVER_vec = {'ODE45', ...
                  'ODE78', ...
                  'ODE113'}; % list of solvers to test (see parameters for implemented solvers)

% processing parameters
par = processParam(par);
dispParam(par);


%% Propagating
solver_end_r_ECI_vec_abs_diff = [];
solver_end_time_vec = [];

for solver = 1:length(par.SOLVER_vec)
    par.SOLVER = char(par.SOLVER_vec(solver));

    end_time_vec = [];
    end_ECI_vec = [];

    for i = 1:1:nb_conv_analy
        dispLine('.');
    
        % changing parameters
        par.REL_TOL = par.REL_TOL_vec(i);
        par.ABS_TOL = par.ABS_TOL_vec(i);
    
        % solving
        tic;
        [time, ECI] = propagator(par);
        ex_time = toc;
        
        % saving result
        end_time_vec = [end_time_vec; ex_time];
        end_ECI_vec = [end_ECI_vec; ECI(end,1:3)];
    end

    end_r_ECI_vec = vecnorm(end_ECI_vec, 2, 2);
    solver_end_r_ECI_vec_abs_diff = [solver_end_r_ECI_vec_abs_diff, abs(end_r_ECI_vec - end_r_ECI_vec(end))];

    solver_end_time_vec = [solver_end_time_vec, end_time_vec];
end


%% Plotting results
figure('Name', 'Convergence Analysis');
yyaxis right
semilogx(par.REL_TOL_vec, solver_end_time_vec *1000, 'LineWidth', 2); hold on;
set(gca, 'xdir', 'reverse');
set(gca, 'XScale', 'log', 'YScale', 'linear')
grid on;
xlabel('tolerance [-]');
ylabel('Computation time [ms]')
xlim([par.REL_TOL_vec(end), par.REL_TOL_vec(1)])

yyaxis left
plot(par.REL_TOL_vec, solver_end_r_ECI_vec_abs_diff, 'LineWidth', 2); hold on;
set(gca, 'xdir', 'reverse');
set(gca, 'XScale', 'log', 'YScale', 'log')
grid on;
ylabel({'norm of r in ECI [m]', ...
        ['around value at ', num2str(par.REL_TOL_vec(end), '%.0e')], ...
        '(last value is thus 0)'});


legend(par.SOLVER_vec, 'Location', 'north')

if par.PRINT_PDF
    fig2pdf(gcf, 'convergence', 1.5, 1.5, par.PDF_FOLDER)
end

