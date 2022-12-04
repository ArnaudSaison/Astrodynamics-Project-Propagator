function [tout, stateout, varargout] = propagator(par)
% PROPAGATOR solves the equation of motion
% 
% Inputs: 
%   par = 
%       set of parameters for the propagator, defines what perturbations
%       are taken into account, parameters for the solver, etc
% 
% Ouputs:
%   solution of propagated orbit
% 
% 

%% pre-processing for handling bulkTLEs
% Adds time steps for precise time of additional TLEs.
% This allows for later precise comparisons.
nargoutchk(1,4); % check that correct nb of output arguments

if nargout == 3
    error('If you are using the bulkTLEs parameters, make sure you take both time and ECI as additional outputs.')

elseif nargout == 4
    if isfield(par, 'BULKTLES_FILENAME')
        bulk.orignal_length = length(par.tspan);

        % computing additional times
        bulk.times = [];

        for tle = 2:length(par.bulkTLEs) % first TLE already in time steps
            bulk.times = [bulk.times, seconds(min(abs(datetime(par.Orb_elem0.utc_vec) ...
                                      - datetime(par.bulkTLEs(tle).elem.utc_vec))))];
        end

        % adding time steps
        par.tspan = [par.tspan, bulk.times];

        % sorting new time steps while saving position of new steps
        % this is required to reconstruct the orignal t.span afterwards
        [par.tspan, bulk.sortingI] = sort(par.tspan);

        [~, sortingI] = sort(bulk.sortingI); % magic trick (yes, it works)
        bulk.sortingI = sortingI;

    else
        error(['You tried outputting bulkTLE outputs, but did not provide a bulkTLEs parameter. ', ...
               'Try adding the parameters, or use only 1 or 2 outputs.'])

    end
end

%% Actual propagator
% display
disp(['Solving ODE using ', par.SOLVER, ' ...'])

% ODE
opts = odeset("RelTol", par.REL_TOL, "AbsTol", par.ABS_TOL, "Stats", par.displ_stats);

tic
switch par.SOLVER
    case {'ODE113'}
        [tout, stateout] = ode113(@(t, y) diffEq(t, y, par), par.tspan, par.ECI0, opts);
    case {'ODE78'}
        [tout, stateout] = ode78(@(t, y) diffEq(t, y, par), par.tspan, par.ECI0, opts);
    case {'ODE45'}
        [tout, stateout] = ode45(@(t, y) diffEq(t, y, par), par.tspan, par.ECI0, opts);
    otherwise
        error('par.SOLVER specifies unknown MATLAB solver.')
end
toc

%% post-processing for handling bulkTLEs
% post processing for bulk TLEs
if nargout == 4
    if isfield(par, 'BULKTLES_FILENAME')
        % bulk TLE propagated values
        varargout{1} = tout(bulk.sortingI(bulk.orignal_length+1:end));
        varargout{2} = stateout(bulk.sortingI(bulk.orignal_length+1:end), :);

        % orignal values for specs t.span
        tout = tout(bulk.sortingI(1:bulk.orignal_length));
        stateout = stateout(bulk.sortingI(1:bulk.orignal_length), :);
    end
end

end