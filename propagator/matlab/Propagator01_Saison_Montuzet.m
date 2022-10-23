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
v0 = [0,v_mag-1,4];

% Step
n_step = 1000;
t_end = 1*24*3600;
tspan = linspace(0,t_end,n_step);

% Array
state0 = [r0,v0];

% ODE
opts = odeset("RelTol",1e-13,"AbsTol",1e-15,"Stats","on");

tic
[tout,stateout] = ode78(@(t, y) diffEq(t, y, earth_mu), tspan, state0, opts);
toc

% Plot earth and orbit
plot_3D(earth_radius,stateout);
axis equal;

