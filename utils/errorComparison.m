function [fig_ax] = errorComparison(par, time, time_vec, ECI, LLA, ECI2, LLA2)
% ERRORCOMPARISON computes and plots difference between inputs
%

% figures dimensions
fig_size = 1.5;
fig_AR = 1.5;

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

figure('Name', 'Absolute difference in ECI', 'WindowStyle', 'docked')
plot(datetime(time_vec), [diff_abs_eci, vecnorm(diff_abs_eci, 2, 2)]); hold on;
%plotDayLines(time(end))
grid on
ylabel('Distance error [m]')
xlabel('Time')
legend({'x', 'y', 'z', 'norm'}, ...
       'Location','southwest')
xtickangle(90);
xticksCustomDate();

if par.PRINT_PDF
    fig2pdf(gcf, 'error_abs_ECI', fig_size, fig_AR, par.PDF_FOLDER)
end

fig_ax.ECI_error = gca;


%% absolute difference in LLA (latitude longitude altitude)
diff_abs_lla  = [(LLA(:,1) - LLA2(:,1)), ...
                 (LLA(:,2) - LLA2(:,2)), ...
                 (LLA(:,3) - LLA2(:,3))];

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

figure('Name', 'Absolute difference in Altitude', 'WindowStyle', 'docked')
% for the altitude
plot(datetime(time_vec), diff_abs_lla(:,3)); hold on;
%plotDayLines(time(end))
grid on
ylabel('Altitude error [m]')
%xlabel('Time')
legend({'altitude'})
xtickangle(90);
xticksCustomDate();

if par.PRINT_PDF
    fig2pdf(gcf, 'error_abs_LLA_alt', fig_size, fig_AR, par.PDF_FOLDER)
end

fig_ax.alt_error = gca;

figure('Name', 'Absolute difference in LongLat', 'WindowStyle', 'docked')
% for lat and long
plot(datetime(time_vec), diff_abs_lla(:,1:2)); hold on;
%plotDayLines(time(end))
grid on
ylabel('Error [°]')
xlabel('Time')
legend({'lat', 'long'}, 'Location', 'northwest')
xtickangle(90);
xticksCustomDate();

if par.PRINT_PDF
    fig2pdf(gcf, 'error_abs_LLA_LongLat', fig_size, fig_AR, par.PDF_FOLDER)
end

fig_ax.LongLat_error = gca;

end