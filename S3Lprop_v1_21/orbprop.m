function [t, oe, parameters, cartesian, geodetic] = orbprop(oe0, varargin)

% 
% S3L ORBITAL PROPAGATOR
% 
% [t, oe, parameters, cartesian, geodetic] = orbprop(oe0, varargin)
% 
% Inputs:
% - oe0: 6-element vector defining the initial state of the satellite. The
%       elements are ordered as follows:
%       - oe0(1) = semi-major axis [m]
%       - oe0(2) = orbit eccentricity [ ]
%       - oe0(3) = inclination [deg]
%       - oe0(4) = argument of perigee [deg]
%       - oe0(5) = RAAN [deg]
%       - oe0(6) = true anomaly [deg]
% - varargin: it can be either of the following options:
%             - 'VariableName', value, ...
%             - A structured variable overriding only the desired
%               simulation parameters.
%             Given the syntax 'VARIABLE' [UNITS] {DEFAULT}, the available
%             variables (or the fields of the structured variable) are:
%
%             - time [s] {86400}: Duration of the propagation.
%             - YYYY [ ] {current year}: Epoch's year (UTC).
%             - MM [ ] {current month}: Epoch's month (UTC).
%             - DD [ ] {current day}: Epoch's day (UTC).
%             - hh [h] {current hour}: Epoch's hour of the day (UTC).
%             - mm [min] {0}: Epoch's minutes (UTC).
%             - ss [s] {0}: Epoch's seconds (UTC).
%
%             - fmodel [ ] {ones(1, 5)}: Flag toggling on (1) and off (0)
%                   orbital perturbations (all on by default. The 
%                   perturbations are ordered as:
%                   gravitational, drag, SRP, 3rd-body sun, 3rd-body moon.
%
%             - Cd [ ] {2.2}: Drag coefficient;.
%             - accommodation [ ] {1}: Energy accommodation coefficient.
%             - m [kg] {100}: Mass.
%             - sizes [m] {ones(1, 3}: The spacecraft is supposed to be a
%                   rectangular prism of sizes settled in the vector sizes:
%                   [length_along_X, length_along_Y, length_along_Z].
%             - Cr [ ] {1.2 * ones(1, 6)}: Reflectivity coefficient of the
%                   6 faces of the spacecraft with normals:
%                   [I, J, K, -I, -J, -K].
%             - Sd [m^2] {1}: Cross surface of the drag. If set to -1 it is
%                   provided as controlled variable u.adcs in the function
%                   control.m. If set to -2 the method of panels is applied
%                   to estimate drag from the attitude. In this case the 
%                   controlled variables u.adcs is an array of three
%                   elements containing the Euler attitude angles in the
%                   wind frame. In addition, when Sd = -2, the variable Cd
%                   is ignored.
%             - Ss [m^2] {1}: Cross surface of the SRP. If set to -1 it is 
%                   computed. If set to -2 the high-precision SRP is
%                   computed.
%             - Ngrav [ ] {10}: Maximum degree of the gravitational model.
%             - Mgrav [ ] {10}: Maximum order of the gravitational model.
%
%             - density [ ] {3}: Density model. It can be any of:
%                   1 (Harris-Priester),
%                   2 (Jacchia 71),
%                   3 (Jacchia Roberts),
%                   4 (NRLMSISE-00).
%             - nHP [ ] {0}: Parameter of the Harris-priested model.  If it
%                   is set to 0, it is computed in function of the orbital
%                   inclination.
%             - F107 [sfu] {150}: Daily solar flux proxy. If set to -1, the
%                   CelesTrack database is used.
%             - F107avg [sfu] {150}: 81-day solar flux proxy. If set to -1,
%                   the CelesTrack database is used.
%             - Kp [ ] {4}: Geomagnetic activity proxy. If set to -1, the
%                   CelesTrack database is used.
%
%             - ecef [ ] {2 * ones(1, 4)}: Flags toggling ON (1), OFF (0),
%                   and SIMPLIFIED (2) (i.e., rotations and accurte ERA are
%                   just computed once at the beginning of the propagation)
%                   the polar precession, polar nutation, Earth rotation,
%                   and polar wandering.
%             - download [ ] {0}: Flag stating if before propagating, the
%                   database of TAI-UTC, EOP, and CelesTrack have to be
%                   downloaded.
%
%             - integrator [ ] {2}: Choice of the integrator. The possible
%                   choice are:
%                   1 - ODE113
%                   2 - RK87
%                   3 - RK8 (fixed time-step)
%             - RelTol [ ] {1e-10}: relative tolerance.
%             - AbsTol [ ] {1e-10}: absolute tolerance (only for ode113).
%             - dt8 [s] {120}: Time-step of RK8.
%             - dt [s] {120}: time-step of the outputs;
%             - waitbar [ ] {1}: Toggle ON (1) or OFF(0) the waitbar.
%             - control: function handle providing the controlled force and
%                 cross section (if Sd = -1) or the attitude (if Sd = -2),
%                 i.e., u = control(t, X, parameters);
%
%             - plot [ ] {zeros(1, 5)}: Flag stating if the following
%                  figures have to be plot (1) or not (0):
%                  - ground track;
%                  - orbit 3d;
%                  - ground track 3d;
%                  - Keplerian elements;
%                  - Altitude.
% 
% Outputs:
% - t: time vector [s].
% - oe: orbital elements ordered as follows:
%       - oe(:, 1) = semi-major axis [m]
%       - oe(:, 2) = orbit eccentricity [ ]
%       - oe(:, 3) = inclination [deg]
%       - oe(:, 4) = argument of perigee [deg]
%       - oe(:, 5) = RAAN [deg]
%       - oe(:, 6) = true anomaly [deg]
% - parameters: structured variable including all the parameters of the
%               simulations.
% - cartesian: Cartesian position (cartesian(:, 1 : 3) [m]) and velocity
%              (cartesian(:, 4 : 6) [m / s]).
% - geodetic: Geodetic coordinates ordered as follows:
%             - geodetic(:, 1): altitude [m]
%             - geodetic(:, 2): longitude [deg]
%             - geodetic(:, 3): latitude [deg]
% 
% The following toolboxes are used by the propagator:
% - Aerospace Toolbox
% - Control System Toolbox
% - Image Processing Toolbox
% - Mapping Toolbox
% - System Identification Toolbox
% 

clear functions;
run('propagator');
clear functions;

end