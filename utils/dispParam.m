function [] = dispParam(par)
% DISPLPARAM displays processed parameters in an organized view
%   
% This function requires a parameters structure as generated by
% 'processParam.m'.
%

dispLine('=');
disp('<strong>Information from TLE</strong>')
dispLine();
disp(['Name                 | ', par.TLE.processed.name])
disp(['Launch year          | ', num2str(par.TLE.processed.launch_year)])
disp(['UTC [Y,M,D,H,MN,S]   | ', num2str(par.Orb_elem0.utc_vec(1:5), '%-6.0f'), ...
                                 '     ', ...
                                 num2str(par.Orb_elem0.utc_vec(6), '%-6.6f')])
dispLine('=');
disp('<strong>Keplerian Elements from TLE</strong>')
dispKeplerian(par.Orb_elem0.i, ...
              par.Orb_elem0.RAAN, ...
              par.Orb_elem0.ecc, ...
              par.Orb_elem0.omega, ...
              par.Orb_elem0.theta, ...
              par.Orb_elem0.a, ...
              par.Orb_elem0.M);
dispLine('=');
disp('<strong>User parameters summary</strong>')
dispLine();
disp('Perturbations')
dispLine();
disp(['J2 perturbation     ', enabledDisabled(par.ENABLE_J2)])
disp(['Atmospheric drag    ', enabledDisabled(par.ENABLE_DRAG)])
dispLine();
disp('Object properties')
dispLine();
disp(['Mass [kg]            | ', num2str(par.prop.MASS, '%-12.2f')])
disp(['Drag coefficient [-] | ', num2str(par.prop.CD, '%-12.2f')])
disp(['Object area [m^2]    | ', num2str(par.prop.A, '%-12.2f')])
dispLine();
disp('Solver parameters')
dispLine();
disp(['Abs tol              | ', num2str(par.ABS_TOL, '%-12.1e')])
disp(['Rel tol              | ', num2str(par.REL_TOL, '%-12.1e')])
dispLine('=');

end

function status = enabledDisabled(BinaryIn)
% ENABLEDSISABLED returns 'enabled' of the input = 1 / 'disabled' if 0
%

if BinaryIn == 0
    status = '<strong>[ ]</strong> disabled';
else
    status = '<strong>[X]</strong> enabled';
end

end