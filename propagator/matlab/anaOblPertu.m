function AN = anaOblPertu(par)
%ANAOBLPERTU Analytical computation of oblateness perturbation
%   

% special parameters that guarantee existence of specific outputs
AN.J2 = 1;
AN.DRAG = 0;

% Computations
AN.RAAN_dot_avg = -(1.5*sqrt(par.pdata.earth.mu)*par.pdata.earth.J2*par.pdata.earth.radius^2 ...
    / (((1-par.Orb_elem0.ecc^2)^2)*par.Orb_elem0.a^3.5))*cos(deg2rad(par.Orb_elem0.i)) /pi*180*86400;

AN.Omega_dot_avg = (0.75*sqrt(par.pdata.earth.mu)*par.pdata.earth.J2*par.pdata.earth.radius^2 ...
    / (((1-par.Orb_elem0.ecc^2)^2)*par.Orb_elem0.a^3.5))*(4-5*sin(deg2rad(par.Orb_elem0.i))^2) /pi*180*86400;

n = sqrt(par.pdata.earth.mu/par.Orb_elem0.a^3);
p = par.Orb_elem0.a*(1-par.Orb_elem0.ecc^2);

nn  = n*(1+(1.5*par.pdata.earth.J2*par.pdata.earth.radius^2/p^2)*sqrt(1-par.Orb_elem0.ecc^2)*(1-1.5*sin(deg2rad(par.Orb_elem0.i))^2));

AN.RAAN = par.Orb_elem0.RAAN - (1.5*par.pdata.earth.J2*par.pdata.earth.radius^2/p^2*cos(deg2rad(par.Orb_elem0.i)))*nn*86400;
AN.Omega =  par.Orb_elem0.omega + (1.5*par.pdata.earth.J2*par.pdata.earth.radius^2/p^2*(2-2.5*sin(deg2rad(par.Orb_elem0.i))^2))*nn*86400;

% Display
disp(['<strong>Analytical Elements after ', num2str(par.T_END /24/3600, '%.2f'), ' day(s) </strong>'])
dispLine('-');
disp(['RAAN dot average [deg/day]    | ', num2str(AN.RAAN_dot_avg, '%-12.2f')])
disp(['Omega dot average [deg/day]   | ', num2str(AN.Omega_dot_avg, '%-12.2f')])
dispLine('=');

% functions
AN.RAAN_plt = par.Orb_elem0.RAAN + par.tspan * AN.RAAN_dot_avg /86400;
AN.Omega_plt = AN.Omega + par.tspan * AN.Omega_dot_avg /86400;

AN.RAAN_plt = AN.RAAN_plt';
AN.Omega_plt = AN.Omega_plt';

end

