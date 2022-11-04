function [] = dispKeplerian(i, RAAN, ecc, omega, theta, a, M)
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
disp(['Inclination [deg]    | ', num2str(i, '%-12.6f')])
disp(['RAAN [deg]           | ', num2str(RAAN, '%-12.6f')])
disp(['Eccentricity [-]     | ', num2str(ecc, '%-12.6f')])
disp(['Arg of peri [deg]    | ', num2str(omega, '%-12.6f')])
disp(['True anomaly [deg]   | ', num2str(theta, '%-12.6f')])
disp(['Mean anomaly [deg]   | ', num2str(M, '%-12.6f')])
disp(['Semi major axis [m]  | ', num2str(a, '%-12.6f')])

end

