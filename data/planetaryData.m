function pdata = planetaryData()
% PLANETARYDATA() returns useful astronomical constants
%
% Inputs: -
% 
% Ouputs:
%   see code
%
% Example:
%   pdata = planetaryData()
%

pdata.G = 6.67408e-11;              % [m^3.kg^-1.s^-2] gravitational constant 

sun.name = 'Sun';                   % [str] name
sun.mass = 1.989e30;                % [kg] mass
sun.mu = 1.32712e11;                % [m^3.s^-2] gravitational parameter
sun.radius = 695700e3;              % [m] radius
sun.omega_o = 282.94*pi/180;        % [rad]
sun.lag = 30*pi/180;                % [rad] lag

earth.name = 'Earth';               % [str] name
earth.mass = 5.972e24;              % [kg] mass
earth.mu = 3.986004418e14;          % [m^3.s^-2] gravitational parameter
%        ± 0.000000008e14
earth.radius = 6378.137e3;          % [m] radius
earth.J2 = 1.08262668e-3;           % [-] J2 coefficient
%earth.J2 = 1.082626173852e-3;           % [-] J2 coefficient
earth.atm_rot = [0,0,72.9211e-6];   % [rad/s]


% output
pdata.earth = earth;
pdata.sun = sun;
pdata.atmo =   [100000,4.974e-7,4.974e-7; ... % Harris priester data
                120000,2.490e-8,2.490e-8;
                130000,8.377e-9,8.710e-9;
                140000,3.899e-9,4.059e-9;
                150000,2.122e-9,2.215e-9;
                160000,1.263e-9,1.344e-9;
                170000,8.008e-10,8.758e-10;
                180000,5.283e-10,6.010e-10;
                190000,3.617e-10,4.297e-10;
                200000,2.557e-10,3.162e-10;
                210000,1.839e-10,2.396e-10;
                220000,1.341e-10,1.853e-10;
                230000,9.949e-11,1.455e-10;
                240000,7.488e-11,1.157e-10;
                250000,5.709e-11,9.308e-11;
                260000,4.403e-11,7.555e-11;
                280000,2.697e-11,5.095e-11;
                290000,2.139e-11,4.226e-11;
                300000,1.708e-11,3.526e-11;
                320000,1.099e-11,2.511e-11;
                340000,7.214e-12,1.819e-11;
                360000,4.824e-12,1.337e-11;
                380000,3.274e-12,9.955e-12;
                400000,2.249e-12,7.492e-12;
                420000,1.558e-12,5.684e-12;
                440000,1.091e-12,4.355e-12;
                460000,7.701e-13,3.362e-12;
                480000,5.474e-13,2.612e-12;
                500000,3.916e-13,2.042e-12;
                520000,2.819e-13,1.605e-12;
                540000,2.042e-13,1.267e-12;
                560000,1.488e-13,1.005e-12;
                580000,1.092e-13,7.997e-13;
                600000,8.070e-14,6.390e-13;
                620000,6.012e-14,5.123e-13;
                640000,4.519e-14,4.121e-13;
                660000,3.430e-14,3.325e-13;
                680000,2.620e-14,2.691e-13;
                700000,2.043e-14,2.185e-13;
                720000,1.607e-14,1.779e-13;
                760000,1.036e-14,1.190e-13;
                780000,8.496e-15,9.776e-14;
                800000,7.069e-15,8.059e-14;
                840000,4.680e-15,5.741e-14;
                880000,3.200e-15,4.210e-14;
                920000,2.210e-15,3.130e-14;
                960000,1.560e-15,2.360e-14;
                100000,1.150e-15,1.810e-14;];


end