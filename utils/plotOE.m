function [fig_ax] = plotOE(par, time, time_vec, OE, LLA, AN)
%PLOTOE plots the orbital elements
%   

% figures dimensions
fig_size = 1.5;
fig_AR = 1.5;

% line style
line_color = 'red';
line_color2 = 'blue';
line_color3 = 'green';

marker_color = 'black';
marker_type = 'x';


%% Inclination variation
% % useful when inclination is not supposed to changed
% figure('Name', 'OE: i variation', 'WindowStyle', 'docked');
% plot(datetime(time_vec), OE.i - OE.i(1))
% xtickangle(90);
% ylabel(['Variation of i around ', num2str(OE.i(1), '%.2f'), '° [deg]'])
% xlabel('Time')
% xticksCustomDate();
% 
% % print to PDF
% if par.PRINT_PDF
%     fig2pdf(gcf, 'OE_i_variation', fig_size, fig_AR, par.PDF_FOLDER)
% end

%% Inclination
[time_vec_temp, angle_temp] = angleDiscon(time_vec, OE.i);
[isCst_temp, middle_temp] = plotConstant(angle_temp, 1e-3);
figure('Name', 'OE: i', 'WindowStyle', 'docked');
plot(datetime(time_vec_temp), angle_temp - middle_temp * isCst_temp, 'Color', line_color); hold on;
xtickangle(90);
ylabel('Inclination [deg]')
if isCst_temp, ylabel({gca().YLabel.String, ['around ', num2str(middle_temp, '%.2f')]}); end
xlabel('Time')
xticksCustomDate();
betterYLim(OE.i - middle_temp * isCst_temp, 0.1, 0 - isCst_temp * 360, 90);

% adding TLEs on plot if available (first one is skipped)
if isfield(par, 'BULKTLES_FILENAME')
    for i = 1:length(par.bulkTLEs)
        plot(datetime(par.bulkTLEs(i).elem.utc_vec), ...
             par.bulkTLEs(i).elem.i, ...
             'Marker', marker_type, ...
             'Color', marker_color, ...
             'MarkerFaceColor', marker_color, ...
             'LineWidth', 2, ...
             'LineStyle', 'none'); hold on;
    end
end

if par.PRINT_PDF
    fig2pdf(gcf, 'OE_i', fig_size, fig_AR, par.PDF_FOLDER)
end
fig_ax.i = gca;

%% RAAN
[time_vec_temp, angle_temp] = angleDiscon(time_vec, OE.RAAN);
[isCst_temp, middle_temp] = plotConstant(angle_temp, 1e-3);
figure('Name', 'OE: RAAN', 'WindowStyle', 'docked');
if AN.J2 == 1
    [time_vec_temp2, angle_temp2] = angleDiscon(time_vec, AN.RAAN_plt); 
    plot(datetime(time_vec_temp2), angle_temp2, 'Color', line_color2); hold on;
end
plot(datetime(time_vec_temp), angle_temp - middle_temp * isCst_temp, 'Color', line_color); hold on;
xtickangle(90);
ylabel('RAAN \Omega [deg]')
if isCst_temp, ylabel({gca().YLabel.String, ['around ', num2str(middle_temp, '%.2f')]}); end
xlabel('Time')
xticksCustomDate();
betterYLim(OE.RAAN - middle_temp * isCst_temp, 0.1, 0 - isCst_temp * 360, 360);

% adding TLEs on plot if available (first one is skipped)
if isfield(par, 'BULKTLES_FILENAME')
    for i = 1:length(par.bulkTLEs)
        plot(datetime(par.bulkTLEs(i).elem.utc_vec), ...
             par.bulkTLEs(i).elem.RAAN, ...
             'Marker', marker_type, ...
             'Color', marker_color, ...
             'MarkerFaceColor', marker_color, ...
             'LineWidth', 2, ...
             'LineStyle', 'none'); hold on;
    end
end

if par.PRINT_PDF
    fig2pdf(gcf, 'OE_RAAN', fig_size, fig_AR, par.PDF_FOLDER)
end
fig_ax.RAAN = gca;

%% Eccentricity
[isCst_temp, middle_temp] = plotConstant(OE.ecc, 1e-3);
figure('Name', 'OE: ecc', 'WindowStyle', 'docked');
plot(datetime(time_vec), OE.ecc - middle_temp * isCst_temp, 'Color', line_color); hold on;
xtickangle(90);
ylabel('Eccentricity [-]')
if isCst_temp, ylabel({gca().YLabel.String, ['around ', num2str(middle_temp, '%.2e')]}); end
xlabel('Time')
xticksCustomDate();
betterYLim(OE.ecc - middle_temp * isCst_temp, 0.1, 0 - isCst_temp * 1, 1);

% adding TLEs on plot if available (first one is skipped)
if isfield(par, 'BULKTLES_FILENAME')
    for i = 1:length(par.bulkTLEs)
        plot(datetime(par.bulkTLEs(i).elem.utc_vec), ...
             par.bulkTLEs(i).elem.ecc, ...
             'Marker', marker_type, ...
             'Color', marker_color, ...
             'MarkerFaceColor', marker_color, ...
             'LineWidth', 2, ...
             'LineStyle', 'none'); hold on;
    end
end

if par.PRINT_PDF
    fig2pdf(gcf, 'OE_ecc', fig_size, fig_AR, par.PDF_FOLDER)
end
fig_ax.ecc = gca;

%% Argument of perigee (omega)
[time_vec_temp, angle_temp] = angleDiscon(time_vec, OE.omega);
[isCst_temp, middle_temp] = plotConstant(angle_temp, 1e-3);
figure('Name', 'OE: omega', 'WindowStyle', 'docked');
if AN.J2 == 1
    [time_vec_temp2, angle_temp2] = angleDiscon(time_vec, AN.Omega_plt); 
    plot(datetime(time_vec_temp2), angle_temp2, 'Color', line_color2); hold on;
end
plot(datetime(time_vec_temp), angle_temp - middle_temp * isCst_temp, 'Color', line_color); hold on;
xtickangle(90);
ylabel('Argument of perigee \omega [deg]')
if isCst_temp, ylabel({gca().YLabel.String, ['around ', num2str(middle_temp, '%.2f')]}); end
xlabel('Time')
xticksCustomDate();
ylim([0, 360])
betterYLim(OE.omega - middle_temp * isCst_temp, 0.1, 0 - isCst_temp * 360, 360);

% adding TLEs on plot if available (first one is skipped)
if isfield(par, 'BULKTLES_FILENAME')
    for i = 1:length(par.bulkTLEs)
        plot(datetime(par.bulkTLEs(i).elem.utc_vec), ...
             par.bulkTLEs(i).elem.omega, ...
             'Marker', marker_type, ...
             'Color', marker_color, ...
             'MarkerFaceColor', marker_color, ...
             'LineWidth', 2, ...
             'LineStyle', 'none'); hold on;
    end
end

if par.PRINT_PDF
    fig2pdf(gcf, 'OE_omega', fig_size, fig_AR, par.PDF_FOLDER)
end
fig_ax.omega = gca;

%% True anomaly (theta)
[time_vec_temp, angle_temp] = angleDiscon(time_vec, OE.theta);
[isCst_temp, middle_temp] = plotConstant(angle_temp, 1e-3);
figure('Name', 'OE: theta', 'WindowStyle', 'docked');
plot(datetime(time_vec_temp), angle_temp - middle_temp * isCst_temp, 'Color', line_color); hold on;
xtickangle(90);
ylabel('True anomaly \theta [deg]')
if isCst_temp, ylabel({gca().YLabel.String, ['around ', num2str(middle_temp, '%.2f')]}); end
xlabel('Time')
xticksCustomDate();
betterYLim(OE.theta - middle_temp * isCst_temp, 0.1, 0 - isCst_temp * 360, 360);
yticks(0:45:360);

% adding TLEs on plot if available (first one is skipped)
if isfield(par, 'BULKTLES_FILENAME')
    for i = 1:length(par.bulkTLEs)
        plot(datetime(par.bulkTLEs(i).elem.utc_vec), ...
             par.bulkTLEs(i).elem.theta, ...
             'Marker', marker_type, ...
             'Color', marker_color, ...
             'MarkerFaceColor', marker_color, ...
             'LineWidth', 2, ...
             'LineStyle', 'none'); hold on;
    end
end

if par.PRINT_PDF
    fig2pdf(gcf, 'OE_theta', fig_size, fig_AR, par.PDF_FOLDER)
end
fig_ax.theta = gca;

%% Semi major axis
[isCst_temp, middle_temp] = plotConstant(OE.a /1000, 1e-3);
figure('Name', 'OE: a', 'WindowStyle', 'docked');
if AN.DRAG == 1
    plot(datetime(time_vec), AN.a_min_plt /1000, ...
         'Color', line_color2, 'DisplayName', 'a_{min}'); hold on;
    plot(datetime(time_vec), AN.a_max_plt /1000, ...
         'Color', line_color3, 'DisplayName', 'a_{max}'); hold on;
    legend('Location', 'west');
end
plot(datetime(time_vec), OE.a /1000 - middle_temp * isCst_temp, ...
     'Color', line_color, 'DisplayName', 'a'); hold on;
xtickangle(90);
ylabel('Semi-major axis [km]')
if isCst_temp, ylabel({gca().YLabel.String, ['around ', num2str(middle_temp, '%.2f')]}); end
xlabel('Time')
xticksCustomDate();
betterYLim(OE.a /1000 - middle_temp * isCst_temp, 0.11, par.pdata.earth.radius /1000 - isCst_temp * 2 * par.pdata.earth.radius /1000, 1e20);

% adding TLEs on plot if available (first one is skipped)
if isfield(par, 'BULKTLES_FILENAME')
    for i = 1:length(par.bulkTLEs)
        plot(datetime(par.bulkTLEs(i).elem.utc_vec), ...
             par.bulkTLEs(i).elem.a /1000, ...
             'Marker', marker_type, ...
             'Color', marker_color, ...
             'MarkerFaceColor', marker_color, ...
             'LineWidth', 2, ...
             'LineStyle', 'none', ...
             'DisplayName', 'TLE'); hold on;
    end
end

if par.PRINT_PDF
    fig2pdf(gcf, 'OE_a', fig_size, fig_AR, par.PDF_FOLDER)
end
fig_ax.a = gca;

%% Altitude
figure('Name', 'Altitude', 'WindowStyle', 'docked');
plot(datetime(time_vec), LLA(:,3) /1000, 'Color', line_color, ...
     'DisplayName', 'Altitude'); hold on;
xtickangle(90);
ylabel('Altitude [km]')
xlabel('Time')
xticksCustomDate();
betterYLim(LLA(:,3) /1000, 0.1, 0, 1e20);

if AN.DRAG == 1
    plot(datetime(time_vec), AN.a_min_plt_alt /1000, ...
         'Color', line_color2, 'DisplayName', 'a_{min}'); hold on;
    plot(datetime(time_vec), AN.a_max_plt_alt /1000, ...
         'Color', line_color3, 'DisplayName', 'a_{max}'); hold on;
    legend('Location', 'southwest');
end

if par.PRINT_PDF
    fig2pdf(gcf, 'altitude', fig_size, fig_AR, par.PDF_FOLDER)
end
fig_ax.altitude = gca;

end


