function AN = anaNoPertu(par)
%ANANOPERTU analytical computation without perturbations
%   

% special parameters that guarantee existence of specific outputs
AN.J2 = 0;
AN.DRAG = 0;

% Computations
AN.h = norm(par.ECI0(1:3))*norm(par.ECI0(4:6)); % angular momentum
AN.periapse = AN.h^2/(par.pdata.earth.mu*(1+par.Orb_elem0.ecc));    % [m]
AN.apoapse =  AN.h^2/(par.pdata.earth.mu*(1-par.Orb_elem0.ecc));    % [m]
AN.T = 2*pi*sqrt(par.Orb_elem0.a^3/par.pdata.earth.mu);             % [seconds]

% for i=1:721
%     Alt(i) = norm(ECI(i,1:3));
% end
% AN.minAlt = min(Alt);
% AN.maxAlt = max(Alt);

% Displaying
dispLine('=');
disp('<strong>Analytical Elements</strong>')
dispLine('-');
disp(['Periapse  [m]       | ', num2str(AN.periapse, '%-12.2f')])
disp(['Apoapsis  [m]       | ', num2str(AN.apoapse, '%-12.2f')])
disp(['Orbital period [s]  | ', num2str(AN.T/60, '%-12.2f')])

end

