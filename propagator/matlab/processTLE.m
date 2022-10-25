function [TLE, elem, ECI] = processTLE(par)
% PROCESSTLE computes the initial state for the propagator
%   Can parse TLEs (Two Line Elements), and generate state for the
%   propagator based on TLEs
%
% Inputs:
%   par = user parameters structure created by 'parameters.m'
%
% Output:
%   TLE = structure containing all values found in the TLE
%   elem = structure with fields
%       ECI = [x, y, z, x_dot, y_dot, z_dot]
%       name = str of object name
%       ID = str of object ID
%       internat_ID = str of international ID
%       epoch = [launch_year, fractional_launch_day]
%       classi = char of classification
%       
%       
%

%% Processing TLE
% Catalog ID
TLE.catalog_nb = str2double(par.TLE.L1(3:7));

% Classification (U: unclassified, C: classified, S: secret)
TLE.classification = par.TLE.L1(8);

% Launch year
TLE.launch_year = str2double(par.TLE.L1(10:11));

% Epoch
TLE.epoch_year = str2double(par.TLE.L1(19:20));
TLE.epoch_day = str2double(par.TLE.L1(21:32));

if TLE.epoch_year > 57
    TLE.epoch_year = TLE.epoch_year + 1900;
else
    TLE.epoch_year = TLE.epoch_year + 2000;
end

% Drag (B_star = CD*Rho*A/2*m)
TLE.B_star_drag = str2double([par.TLE.L1(54) '0.' par.TLE.L1(55:59) 'e' par.TLE.L1(60:61)]);

% Inclination
elem.i = str2double(par.TLE.L2(9:16)); % [deg]

% Right ascension of the ascending node
elem.RAAN = str2double(par.TLE.L2(18:25)); % [deg]

% Eccentricity
elem.ecc = str2double(['0.' par.TLE.L2(27:33)]); % [-]

% Argument of perigee
elem.omega = str2double(par.TLE.L2(35:42)); % [deg]

% Mean anomaly
elem.theta = str2double(par.TLE.L2(44:51));

% Mean motion
elem.rev_per_day = str2double(par.TLE.L2(53:63));  
elem.a = (par.pdata.earth.mu / (elem.rev_per_day * 2*pi/86400)^2)^(1/3); % semi major axis

% Revolution number at epoch
elem.orbit_nb_epoch = str2double(par.TLE.L2(64:68));  

%% Conversion to ECI
% using Aerospace Toolbox
[r_ijk, v_ijk] = keplerian2ijk(elem.a, elem.ecc, elem.i, elem.RAAN, elem.omega, elem.theta);

ECI = [r_ijk', v_ijk'];

end