function [] = dispKeplerian(i, RAAN, ecc, omega, theta, a)
%DISPKEPLERIAN displays keplerian elements
%
% Inputs:
%   i = inclination
%   RAAN = right ascension of ascending node
%   ecc = eccentricity
%   omega = argument of periapsis
%   theta = mean anomaly
%   a = semi major axis
%   

disp('<strong>Keplerian Elements from TLE</strong>')
dispLine();
disp(['Inclination [deg]    | ', num2str(i, '%-12.2f')])
disp(['RAAN [deg]           | ', num2str(RAAN, '%-12.2f')])
disp(['Eccentricity [-]     | ', num2str(ecc, '%-12.2f')])
disp(['Arg of peri [deg]    | ', num2str(omega, '%-12.2f')])
disp(['Mean anomaly [deg]   | ', num2str(theta, '%-12.2f')])
disp(['Semi major axis [m]  | ', num2str(a, '%-12.2f')])

end

