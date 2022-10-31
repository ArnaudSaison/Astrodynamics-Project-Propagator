function [theta] = mean2trueAnomaly(meanAno, ecc)
%MEAN2TRUEANOMALY converts mean anomaly to true anomaly
%

options = optimoptions('fsolve', 'MaxIterations', 500, 'FunctionTolerance', 1e-10, 'FiniteDifferenceType', 'central');

% Eccentric anomaly
eccAno =@(x) x - ecc * sin(x) - deg2rad(meanAno);
E = fsolve(eccAno, 0);

% defining the relation between true anomaly and mean anomaly
% trueAno =@(x) 2 * atan(sqrt((1 - ecc)/(1 + ecc)) * tan(x / 2)) - E;
% theta = fsolve(trueAno, 0)
sinv = (sqrt(1-ecc.^2).*sin(E))./(1-ecc.*cos(E));   % Sine of true anomaly
cosv = (cos(E)-ecc)./(1-ecc.*cos(E));               % Cosine of true anomaly
theta = atan2(sinv,cosv);                           % True anomaly  [rad]
if theta < 0
    theta = 2*pi+theta;
end

theta = rad2deg(theta);

end
