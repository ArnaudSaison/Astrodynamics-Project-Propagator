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
% pdata.G = 6.67408e-20;              % [km^3.kg^-1.s^-2] gravitational constant 

sun.name = 'Sun';                   % [str] name
sun.mass = 1.989e30;                % [kg] mass
sun.mu = 1.32712e11;                % [m^3.s^-2] gravitational parameter
sun.radius = 695700e3;              % [m] radius

earth.name = 'Earth';               % [str] name
earth.mass = 5.972e24;              % [kg] mass
earth.mu = earth.mass * pdata.G;    % [km^3.s^-2] gravitational parameter
% earth.mu = 398600;
earth.radius = 6378.0e3;            % [m] radius
% earth.radius = 6378.0e0;            % [km] radius
earth.J2 = 1.082635854e-3;          % 


% output
pdata.earth = earth;
pdata.sun = sun;

end