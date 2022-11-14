function errorComparison(par, time, ECI, LLA, ECI2, LLA2)
% ERRORCOMPARISON computes and plots difference between inputs
%

%% relative difference in ECI
% diff_rel_eci = [abs((ECI(:,1) - ECI2(:,1))./ECI2(:,1)), ...
%                 abs((ECI(:,2) - ECI2(:,2))./ECI2(:,2)), ...
%                 abs((ECI(:,3) - ECI2(:,3))./ECI2(:,3))];
% 
% figure('Name', 'Relative difference in ECI')
% plot(diff_rel_eci)
% grid on
% legend({'x', 'y', 'z'})

%% absolute difference in ECI
diff_abs_eci = [(ECI(:,1) - ECI2(:,1)), ...
                (ECI(:,2) - ECI2(:,2)), ...
                (ECI(:,3) - ECI2(:,3))];

figure('Name', 'Absolute difference in ECI')
plot(time, [diff_abs_eci, vecnorm(diff_abs_eci, 2, 2)]); hold on;
plotDayLines(time(end))
grid on
ylabel('Distance error [m]')
xlabel('Time [s]')
legend({'x', 'y', 'z', 'norm'}, ...
       'Location','southwest')

if par.PRINT_PDF
    fig2pdf(gcf, 'error_abs_ECI', 1, 1.5, par.PDF_FOLDER)
end

%% absolute difference in LLA (latitude longitude altitude)
diff_abs_lla  = [(LLA(:,1) - LLA2(:,3)), ...
                 (LLA(:,2) - LLA2(:,2)), ...
                 (LLA(:,3) - LLA2(:,1))];

% cleaning up (because of along-track error, values of longitude can cross 
% the 360° line before one another)
for i = 1:size((diff_abs_lla(:,2)), 1)

    % if value exeeds these bounds, it is practically certain the error has
    % occured
    if diff_abs_lla(i,2) > 300
        diff_abs_lla(i,2) = diff_abs_lla(i,2) - 360;

    elseif diff_abs_lla(i,2) < -300
        diff_abs_lla(i,2) = diff_abs_lla(i,2) + 360;
    end
end

figure('Name', 'Absolute difference in LLA')
% for the altitude
subplot(2,1,1) 
plot(time, diff_abs_lla(:,3)); hold on;
plotDayLines(time(end))
grid on
ylabel('Altitude error [m]')
xlabel('Time [s]')
legend({'altitude'})

% for lat and long
subplot(2,1,2)
plot(time, diff_abs_lla(:,1:2)); hold on;
plotDayLines(time(end))
grid on
ylabel('Error [°]')
xlabel('Time [s]')
legend({'lat', 'long'})

if par.PRINT_PDF
    fig2pdf(gcf, 'error_abs_LLA', 1, 1.5, par.PDF_FOLDER)
end


end