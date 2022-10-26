function [] = dispParam(par)
% DISPLPARAM displays processed parameters in an organized view
%   

dispLine('=');
disp('<strong>Information from TLE</strong>')
dispLine();
disp(['Name                 | ', par.TLE.processed.name])
disp(['Launch year          | ', num2str(par.TLE.processed.launch_year)])
disp(['UTC [Y,M,D,H,MN,S]   | ', num2str(par.Orb_elem0.utc_vec, '%-6.0f')])
dispLine('=');
disp('<strong>Keplerian Elements from TLE</strong>')
dispLine();
disp(['Inclination [deg]    | ', num2str(par.Orb_elem0.i, '%-12.2f')])
disp(['RAAN [deg]           | ', num2str(par.Orb_elem0.RAAN, '%-12.2f')])
disp(['Eccentricity [-]     | ', num2str(par.Orb_elem0.ecc, '%-12.2f')])
disp(['Arg of peri [deg]    | ', num2str(par.Orb_elem0.omega, '%-12.2f')])
disp(['Mean anomaly [deg]   | ', num2str(par.Orb_elem0.theta, '%-12.2f')])
disp(['Semi major axis []   | ', num2str(par.Orb_elem0.theta, '%-12.2f')])
dispLine('=');

end

