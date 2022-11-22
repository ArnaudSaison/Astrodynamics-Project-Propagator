function [time_out, angle_out] = angleDiscon(time_vec, angle)
%ANGLEDISCONTINUITIES adds NaN and NaT values where there are discontinuities
%   Also adds points so that cut is not visible, especially when few points
%   on the graph.
%
% Inputs:
%   time_vec = time vector format (6 colponents)
%   angle = deg
%
% Ouputs:
%   time_out = same format as input
%   angle_out = same format as output
%

% treshold considered to ne discontinuity
tresh = 300;

angle_out = [angle(1)];
time_out = [time_vec(1,:)];

% adding NaN and NaT elements
for i = 1:length(angle)-1

    % if difference larger than treshold, add NaN/T
    % depending if velue increases or decreases, to avoid cuts, adjacent
    % points are added

    if angle(i+1) - angle(i) < -tresh
        % before cut
        angle_out = [angle_out; angle(i+1)+360];
        time_out = [time_out; time_vec(i+1,:)];

        % break in values
        angle_out = [angle_out; NaN];
        time_out = [time_out; [NaN, NaN, NaN, NaN, NaN, NaN]];

        % after cut
        angle_out = [angle_out; angle(i)-360];
        time_out = [time_out; time_vec(i,:)];

    elseif angle(i+1) - angle(i) > tresh
        % before cut
        angle_out = [angle_out; angle(i)-360];
        time_out = [time_out; time_vec(i,:)];

        % break in values
        angle_out = [angle_out; NaN];
        time_out = [time_out; [NaN, NaN, NaN, NaN, NaN, NaN]];

        % after cut
        angle_out = [angle_out; angle(i+1)+360];
        time_out = [time_out; time_vec(i+1,:)];

    end

    % always add actual value
    angle_out = [angle_out; angle(i+1)];
    time_out = [time_out; time_vec(i+1,:)];
end

end

