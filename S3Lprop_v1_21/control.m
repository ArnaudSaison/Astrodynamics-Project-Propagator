function u = control(t, x, parameters)

% 
% Example of control function.
% Inputs:
% - t [s]: current simulation time.
% - r [m]: satellite position.
% - v [m / s]: satellite velocity.
% - parameters: structured variable with all the parameters of the
%       simulation.
% 
% Outputs:
%   - u = control variable. It is a 4-to-6-element column vector such that:
%       - u(1 : 3) [N / kg]: Control force in the ECI frame.
%       - u(4) or u(4 : 6) [m^2 or rad]: if parameters.Sd == -1, u(4) is
%             the instantaneous cross section. If parameters.Sd == -2, it
%             is a 3-dimensional vector defining the attitude of the
%             satellite (Euler angles in the wind frame).
% 

r = x(1 : 3);
v = x(4 : 6);
t = t / 3600;

% Control force. Note that F, r, v are in ECI
vDir = v / norm(v);
F = 1e-10 * vDir; % [N / kg]


% Attitude
if parameters.Sd == -1,
    if t < 5,
        adcs = 0.01;
    else
        adcs = 0.02;
    end
elseif parameters.Sd == - 2,
        adcs = pi * [0.5; 0.25; 0]*0; % [sigma; delta; epsilon] [rad]
else
    adcs = 0;
end

% Outputs
u = [F; adcs];

return