function [isCst, middle] = plotConstant(values, treshold)
% PLOTCONSTANT detects is the values are close to constant
%
% Inputs:
%   values = values that have to be tested
%   treshold = (optional) largest charge considered not constant
%
% Outputs:
%   isCst = 1 if values are considered constant / 0 else
%   middle = central value between extremums / 0 if isCst = 0
%

maxi = max(values);
mini = min(values);

isCst = abs(maxi - mini) < treshold;
middle = (maxi + mini)/2;

end
