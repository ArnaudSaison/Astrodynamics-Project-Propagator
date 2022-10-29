function [ECEF] = plotOrbit(par, time, ECI)
% PLOTORBIT Represents the orbit in different ways
%   

%% 3D plot
plot_3D(par.pdata.earth.radius, ECI);

%% 2D altitude
position = ECI(:,1:3);
for n = drange(1:length(position(:,1)))
    h(n,1) = norm(position(n,:))-par.pdata.earth.radius;
end
figure,clf
hold on 
plot(time,h,'g')
xlabel('Time [s]') 
ylabel('Altitude [m]') 
hold off


%% Conversion to ECEF
time_jd = time /86400 + par.Orb_elem0.utc_jd; % adding epoch
dt = datetime(time_jd, 'ConvertFrom', 'juliandate', 'TimeZone', 'UTC'); % to UTC vec
vec = datevec(dt); % eci2ecef only takes vectors

if par.DEBUG
    disp('Converting result to ECEF... (this operation is very slow)')
end

tic
for i = 1:size(vec, 1)
     [r, v] = eci2ecef(vec(i,:), ECI(i,1:3), ECI(i,4:6));
     ECEF(i,:) = [r', v']; % contains both position and velocity
end
toc


%% Using the groundtrack function
grdtrk(ECEF(:,1:3));

end

