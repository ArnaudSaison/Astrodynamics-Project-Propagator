function errorComparison(ECI, LLA, ECI2, LLA2)
% ERRORCOMPARISON
%

% relative difference in ECI
diff_rel_eci = [abs((ECI(:,1) - ECI2(:,1))./ECI2(:,1)), ...
                abs((ECI(:,2) - ECI2(:,2))./ECI2(:,2)), ...
                abs((ECI(:,3) - ECI2(:,3))./ECI2(:,3))];

figure
plot(diff_rel_eci)
grid on
legend({'x', 'y', 'z'})

% absolute difference in ECI
diff_abs_eci = [(ECI(:,1) - ECI2(:,1)), ...
                (ECI(:,2) - ECI2(:,2)), ...
                (ECI(:,3) - ECI2(:,3))];

figure
plot([diff_abs_eci, vecnorm(diff_abs_eci, 2, 2)])
grid on
legend({'x', 'y', 'z', 'norm'})

% absolute difference in LLA
diff_abs_lla  = [(LLA(:,1) - LLA2(:,3)), ...
                 (LLA(:,2) - LLA2(:,2)), ...
                 (LLA(:,3) - LLA2(:,1))];

figure
plot(diff_abs_lla)
grid on
legend({'lat', 'long', 'alt'})

end