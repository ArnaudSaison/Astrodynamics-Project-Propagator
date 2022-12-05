function [] = dispKeplerian(i, RAAN, ecc, omega, theta, a, M)
%DISPKEPLERIAN displays keplerian elements
%
% Inputs:
%   i = inclination
%   RAAN = right ascension of ascending node
%   ecc = eccentricity
%   omega = argument of periapsis
%   theta = true anomaly
%   a = semi major axis
%   M = mean anomaly (optional)
%   

dispLine();
disp(['Inclination [deg]    | ', num2str(i, '%-12.2f')])
disp(['RAAN [deg]           | ', num2str(RAAN, '%-12.2f')])
disp(['Eccentricity [-]     | ', num2str(ecc, '%-12.6f')])
disp(['Arg of peri [deg]    | ', num2str(omega, '%-12.2f')])
disp(['True anomaly [deg]   | ', num2str(theta, '%-12.2f')])
if nargin == 7
disp(['Mean anomaly [deg]   | ', num2str(M, '%-12.2f')])
end
disp(['Semi major axis [m]  | ', num2str(a, '%-12.0f')])

% dispLine();
% disp(['Inclination [deg]    | ', num2str(i, '%-12.10f')])
% disp(['RAAN [deg]           | ', num2str(RAAN, '%-12.10f')])
% disp(['Eccentricity [-]     | ', num2str(ecc, '%-12.10f')])
% disp(['Arg of peri [deg]    | ', num2str(omega, '%-12.10f')])
% disp(['True anomaly [deg]   | ', num2str(theta, '%-12.10f')])
% if nargin == 7
% disp(['Mean anomaly [deg]   | ', num2str(M, '%-12.10f')])
% end
% disp(['Semi major axis [m]  | ', num2str(a, '%-12.10f')])

end

