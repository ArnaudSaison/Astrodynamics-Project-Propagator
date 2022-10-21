function [pos, vel] = sgp4(tsince, tlefile, tlenumber)

% 
% [R, V] = tle2eci(t, tlefile, tlenumber)
% 
% SGP4 orbital propagator.
% 
% Inputs:
%   - t        : Nx1 vector of time of propagation since TLE's epoch [s].
%   - tlefile  : File containing various TLEs.
%   - tlenumber: Number of the TLE to be propagated.
% Outputs:
%   - R        : Nx3 matrix of ECI positions propagated at time t [m].
%   - V        : Nx3 matrix of ECI velocities propagated at time t [m / s].
% 
