clc
clear all
close all

earth_radius = earthRadius/1000;
earth_mu = 398600;



% initial condition of orbit parameters
r_mag = earth_radius + 414;       % km
v_mag = sqrt(earth_mu/r_mag);     % km/s

% initial position and velocity vector
r0 = [r_mag,0,0];
v0 = [0,v_mag,0];
[r0, v0] = tle2eci(TLEISS.txt);
% Time orbit
t_orbit = (r_mag*2*pi)/v_mag;

% Step
n_step = 30*100;
t_end = 100*t_orbit;
tspan = linspace(0,t_end,n_step);

% Array
state0 = [r0,v0];

% ODE
opts = odeset("RelTol",1e-13,"AbsTol",1e-15,"Stats","on");

tic
[tout,stateout] = ode78(@propagator,tspan,state0,opts);
toc

% Plot earth and orbit
plot_3D(earth_radius,stateout);

% xout = stateout(:,1);
% yout = stateout(:,2);
% zout = stateout(:,3);
% grdtrk([xout*1000,yout*1000,zout*1000]);

