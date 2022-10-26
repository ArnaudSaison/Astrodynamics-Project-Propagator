function grdtrk(xECEF)

% 
% This function display the ground track of the spacecraft.
% In input it is required an Nx3 matrix defining N cartesian position in
% the Earth Centered Earth Fixed frame.
% 

n = size(xECEF, 1);

%% Computation of Latitude and longitude
LON = zeros(n, 1);
LAT = zeros(n, 1);
H = zeros(n, 1);

for j = 1 : n,
    [H(j), LON(j), LAT(j)] = ecef2geodetic(xECEF(j, :)');
end

LAT = rad2deg(LAT);
LON = rad2deg(LON);
Hgdtrk = H * 1e-3;

% Find discontinuites
N = length(LAT);
for j = 1 : 1 : (N - 1),
    if abs(LON(j + 1) - LON(j)) > 300,
        LON = [LON(1 : j); NaN; LON((j + 1) : N)];
        LAT = [LAT(1 : j); NaN; LAT((j + 1) : N)];
        Hgdtrk = [Hgdtrk(1 : j); NaN; Hgdtrk((j + 1) : N)];
        N = N + 1;
    end
end

%% Plot
% Font size
set(0, 'defaultaxesfontsize', 16);
set(0, 'defaulttextfontsize', 16);

figure;
box on;
axis on;
view(0, 90);
load coast;
%axesm mercator;
plot(long,lat);
hold on;
grid on;
plot3(LON, LAT, Hgdtrk, 'r', 'linewidth', 0.2);
inizio = plot3(LON(1), LAT(1), Hgdtrk(1), 's', ...
    'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'r', 'MarkerSize', 5);
fine = plot3(LON(end), LAT(end), Hgdtrk(end), 's', ...
    'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'c', 'MarkerSize', 5);
xlabel('Longitude [deg]');
ylabel('Latitude [deg]');
zlabel('Altitude [km]');
xlim([-180 180]);
ylim([-90 90]);
legend([inizio, fine], 'Start', 'End');
title('Ground track');
set(gca, 'xtick', -180 : 60 : 180, 'ytick', -90 : 30 : 90);
hold off;

return

function [h, lambda, phi] = ecef2geodetic(rECEF)

% 
% [h, lambda, phi] = ecef2geodetic(rECEF)
% 
% Provide the geodetic coordinates of a position vector in the ECEF frame.
% 
% Inputs:
%   - rECEF = 3-element column vector defining a position in the ECEF frame
%            [m]
% 
% Outputs:
%   - h = altitude from the reference ellipsoid [m]
%   - lambda = geodetic longitude [rad]
%   - phi = geodetic latitude [rad]
% 
% Ref: MATLAB function ecef2geodetic.
% 
% Lamberto Dell'Elce
% 

persistent a e2 ep2 f b

if isempty(a),
    % Ellipsoid constants
    a  = 6378.137e3; % Semimajor axis
    e2 = 0.081819190842^2; % Square of first eccentricity
    ep2 = e2 / (1 - e2); % Square of second eccentricity
    f = 1 - sqrt(1 - e2); % Flattening
    b = a * (1 - f); % Semiminor axis
end

x = rECEF(1);
y = rECEF(2);
z = rECEF(3);

%% Longitude
lambda = atan2(y,x); % [rad]

%% Latitude
% Distance from Z-axis
RHO = hypot(x,y);

% Bowring's formula for initial parametric (beta) and geodetic (phi)
% latitudes
beta = atan2(z, (1 - f) * RHO);
phi = atan2(z   + b * ep2 * sin(beta)^3,...
            RHO - a * e2  * cos(beta)^3);

% Fixed-point iteration with Bowring's formula
% (typically converges within two or three iterations)
betaNew = atan2((1 - f)*sin(phi), cos(phi));
count = 0;
while any(beta(:) ~= betaNew(:)) && count < 5
    beta = betaNew;
    phi = atan2(z + b * ep2 * sin(beta)^3, ...
        RHO - a * e2  * cos(beta).^3); % [rad]
    betaNew = atan2((1 - f)*sin(phi), cos(phi));
    count = count + 1;
end

%% Altitude
% Calculate ellipsoidal height from the final value for latitude
sin_phi = sin(phi);
N = a / sqrt(1 - e2 * sin_phi^2);
h = RHO * cos(phi) + (z + e2 * N * sin_phi) * sin_phi - N; % [m]

return