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

pdata.G = 6.67408e-11;                  % [m^2.kg^-1.s^-2] gravitational constant 

pdata.sun.name = 'Sun';                 % [str] name
pdata.sun.mass = 1.989e30;              % [kg] mass
pdata.sun.mu = 1.32712e11;              % [m^3] gravitational parameter
pdata.sun.radius = 695700e3;            % [m] radius

pdata.earth.name = 'Earth';             % [str] name
pdata.earth.mass = 5.972e24;            % [kg] mass
pdata.earth.mu = earth.mass * pdata.G;  % [m^3] gravitational parameter
pdata.earth.radius = 6378.0;            % [m] radius
pdata.earth.J2 = 1.082635854e-3;        % 

end