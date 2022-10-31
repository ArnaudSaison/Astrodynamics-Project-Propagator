function [TLE, elem, ECI] = processTLE(par, L0, L1, L2)
% PROCESSTLE computes the initial state for the propagator
%   Can parse TLEs (Two Line Elements), and generate state for the
%   propagator based on TLEs
%
% Inputs:
%   par = user parameters structure created by 'parameters.m'
%
% Output:
%   TLE = structure containing all values found in the TLE
%   elem = structure with fields described below
%       
%

%% Different possible function inputs
if nargin == 1
    L0 = par.TLE.L0;
    L1 = par.TLE.L1;
    L2 = par.TLE.L2;
end


%% Processing TLE
% Name
TLE.name = L0;

% Catalog ID
TLE.catalog_nb = str2double(L1(3:7));

% Classification (U: unclassified, C: classified, S: secret)
TLE.classification = L1(8);

% Launch year
TLE.launch_year = str2double(L1(10:11));

if TLE.launch_year > 57
    TLE.launch_year = TLE.launch_year + 1900;
else
    TLE.launch_year = TLE.launch_year + 2000;
end

% Epoch
TLE.epoch = str2double(L1(19:32));
TLE.epoch_year = str2double(L1(19:20));
TLE.epoch_day = str2double(L1(21:32));

if TLE.epoch_year > 57
    TLE.epoch_year = TLE.epoch_year + 1900;
else
    TLE.epoch_year = TLE.epoch_year + 2000;
end

% Drag (B_star = CD*Rho*A/2*m)
TLE.B_star_drag = str2double([L1(54) '0.' L1(55:59) 'e' L1(60:61)]);

% Inclination
elem.i = str2double(L2(9:16)); % [deg]

% Right ascension of the ascending node
elem.RAAN = str2double(L2(18:25)); % [deg]

% Eccentricity
elem.ecc = str2double(['0.' L2(27:33)]); % [-]

% Argument of perigee
elem.omega = str2double(L2(35:42)); % [deg]

% Mean anomaly
elem.M = str2double(L2(44:51));

% True anomaly
elem.theta = mean2trueAnomaly(elem.M, elem.ecc);

% Mean motion
elem.rev_per_day = str2double(L2(53:63));  
elem.a = (par.pdata.earth.mu / (elem.rev_per_day * 2*pi/86400)^2)^(1/3); % semi major axis

% Revolution number at epoch
elem.orbit_nb_epoch = str2double(L2(64:68));  

%% Conversion to ECI
% using Aerospace Toolbox
[r_ijk, v_ijk] = keplerian2ijk(elem.a, elem.ecc, elem.i, elem.RAAN, elem.omega, elem.theta);

ECI = [r_ijk', v_ijk'];

%% Time conversion
%
% MATLAB is a bit frustrating with time and dates, so I first tried
% converting manually, but I found conflicting information on the actual
% conversion and wasn't sure it was correct. So I tried another method
% which ended up being way more simple, and more importantly, reliable.
%
%
%
%
% year = TLE.epoch_year; % 
% day_of_year = floor(TLE.epoch_day); % non decimal part is day
% 
% decimal_day = TLE.epoch_day - day_of_year; % decimal part of the day
% 
% hh = floor(decimal_day * 24); % hours
% mm = floor((decimal_day * 24 - hh) * 60); % minutes
% ss = floor(((decimal_day * 24 - hh) * 60 - mm) * 60); % seconds
% 
% end_of_month_day = eomday(TLE.epoch_year, 1:12); % number of days in each month for spacified year
% 
% temp = cumsum(end_of_month_day); % last day of each month in day of year format
% month = find(temp >= day_of_year, 1); % first month that has 
% 
% temp = temp(month) - day_of_year;
% date = end_of_month_day(month) - temp;
% 
% elem.utc = [TLE.epoch_year, month, date, hh, mm, ss]


% juliandate where month is set to 0 to force matlab to convert only the 
% year + days and decimals
jd = juliandate(TLE.epoch_year, 0, TLE.epoch_day);

% Conversion to datetime object which can be easily used afterwards
dt = datetime(jd, 'ConvertFrom', 'juliandate', 'TimeZone', 'UTC');

% Conversion to vector
vec = datevec(dt); % [Y,M,D,H,MN,S]

% conversion to date vector
elem.utc_vec = vec;
elem.utc_jd = jd;


end