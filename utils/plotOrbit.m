function [] = plotOrbit(par, time, ECI)
% PLOTORBIT Represents the orbit in different ways
%   

%% 3D plot
plot_3D(par.pdata.earth.radius, ECI);

%% Conversion to ECEF
time_jd = time /86400 + par.Orb_elem0.utc_jd; % adding epoch
dt = datetime(time_jd, 'ConvertFrom', 'juliandate', 'TimeZone', 'UTC'); % to UTC vec
vec = datevec(dt); % eci2ecef only takes vectors

if par.DEBUG
    disp('Converting result to ECEF:')
end

for i = 1:size(vec, 1)
     [r, v] = eci2ecef(vec(i,:), ECI(i,1:3), ECI(i,4:6));
     ECEF(i,:) = [r', v']; % contains both position and velocity
end

if par.DEBUG
    ECEF
end

grdtrk(ECEF(:,1:3));

end

