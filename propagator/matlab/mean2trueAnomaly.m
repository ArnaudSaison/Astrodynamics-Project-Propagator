function [theta] = mean2trueAnomaly(meanAno, ecc)
%MEAN2TRUEANOMALY converts mean anomaly to true anomaly
%

% Eccentric anomaly
eccAno =@(x) x - ecc * sin(x) - deg2rad(meanAno);
E = fsolve(eccAno, 0)

% defining the relation between true anomaly and mean anomaly
trueAno =@(x) 2 * atan(sqrt((1 - ecc)/(1 + ecc)) * tan(x / 2)) - E;
theta = fsolve(trueAno, 0)

theta = rad2deg(theta);

end
