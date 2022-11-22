function betterYLim(data, space, mini, maxi)
%BETTERYLIM allows to give clearance percentage and maximum range for ylim
% Allows to defines blank space around a data, ensure data is always
% centered, while still providing maximum limits.
%   
% Inputs:
%   data = that is in the plot
%   space = fraction of the plot that is left blank above and below graph
%   maxi = maximum value for upper bound of ylim
%   mini = minimum value for lower bound of ylim
%
% Ouputs: -
%

% swath
y_variation = (max(data) - min(data)) * space;

% range
lower = min(data) - y_variation;
upper = max(data) + y_variation;

% boundaries
if lower < mini
    lower = mini;
end

if upper > maxi
    upper = maxi;
end

% plotting limits
ylim([lower, upper]);

end

