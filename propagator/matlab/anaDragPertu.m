function AN = anaDragPertu(par, a, altitude)
%ANADRAGPERTU 
%

% special parameters that guarantee existence of specific outputs
AN.J2 = 0;
AN.DRAG = 1;

rho_min = (1.558e-12);
AN.a_dot_min = - (sqrt((par.Orb_elem0.a+10000)*par.pdata.earth.mu)*rho_min*par.prop.A*par.prop.CD/par.prop.MASS)*86400;

rho_max = (7.492e-12);
AN.a_dot_max = - (sqrt((par.Orb_elem0.a-10000)*par.pdata.earth.mu)*rho_max*par.prop.A*par.prop.CD/par.prop.MASS)*86400;

disp(['<strong>Analytical Elements after ', num2str(par.T_END /24/3600, '%.2f'), ' day(s) </strong>'])
dispLine();
disp(['Semi-major axis variation min [m/day]    | ', num2str(AN.a_dot_min, '%-12.2f')])
disp(['Semi-major axis variation max [m/day]    | ', num2str(AN.a_dot_max, '%-12.2f')])
dispLine('=');

% plot
AN.a_min_plt = mean(a) + par.tspan * AN.a_dot_min /86400;
AN.a_max_plt = mean(a) + par.tspan * AN.a_dot_max /86400;

AN.a_min_plt = AN.a_min_plt';
AN.a_max_plt = AN.a_max_plt';

% plot
AN.a_min_plt_alt = max(altitude) + par.tspan * AN.a_dot_min /86400;
AN.a_max_plt_alt = max(altitude) + par.tspan * AN.a_dot_max /86400;

AN.a_min_plt_alt = AN.a_min_plt_alt';
AN.a_max_plt_alt = AN.a_max_plt_alt';

end

