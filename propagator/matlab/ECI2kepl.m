function [a, ecc, i, RAAN, omega, theta] = ECI2kepl(ECI)
%ECI2KEPL converts a vector of ECI coordinates to orbital elements
%   This function serves the only purpose of converting a vector, which the
%   MATLAB function cannot do.
%
%   a = semi-major axis
%   ecc = eccentricity
%   i = inclination
%   RAAN = right ascension of the ascending node
%   omega = 
%

nb_lines = size(ECI, 1);

empty = zeros(nb_lines, 1);

a = empty;
ecc = empty;
i = empty;
RAAN = empty;
omega = empty;
theta = empty;

for line = 1:nb_lines
    [a(line), ...
     ecc(line), ...
     i(line), ...
     RAAN(line), ...
     omega(line), ...
     theta(line)] = ijk2keplerian(ECI(line,1:3), ECI(line,4:6));
end

end

