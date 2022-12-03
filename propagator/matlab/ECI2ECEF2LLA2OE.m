function [ECEF, LLA, OE, time_vec] = ECI2ECEF2LLA2OE(ECI, time, par)
%ECI2ECEF2LLA2OE does all the conversoins from ECI
%
% Inputs:
%   ECI = [x, y, z, x_dot, y_dot, z_dot] (only the first 3 columns are
%       required) where each is a column vector
%   time = column vector of times [s] corresponding to positions
%   par = parameters structure as defined by 'processParam.m'
%

%% time
if par.DEBUG
    disp('Converting time...')
end

time_jd = time /86400 + par.Orb_elem0.utc_jd; % adding epoch
dt = datetime(time_jd, 'ConvertFrom', 'juliandate', 'TimeZone', 'UTC'); % to UTC vec
time_vec = datevec(dt); % eci2ecef only takes vectors


%% ECEF
if par.DEBUG
    disp('Converting to ECEF... (this operation is very slow)')
end

tic
ECEF = zeros(size(dt, 1), 3);
for i = 1:size(dt, 1)
    r = eci2ecef(dt(i,:), ECI(i,1:3));
    ECEF(i,:) = r'; % contains both position and velocity
end
toc


%% Orbital elements
if par.DEBUG
    disp('Converting to orbital elements...')
end

[OE.a, OE.ecc, OE.i, OE.RAAN, OE.omega, OE.theta] = ECI2kepl(ECI);


%% LLA
% finding lla (latitude longitude altitude)

if par.DEBUG
    disp('Converting to Lat Long Alt...')
end

LLA = ecef2lla(ECEF);

end

