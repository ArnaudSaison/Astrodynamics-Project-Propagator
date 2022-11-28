function [fig_ax] = plotOE(par, time, time_vec, OE, LLA, AN)
%PLOTOE plots the orbital elements
%   

% figures dimensions
fig_size = 1.5;
fig_AR = 1.5;

% line style
line_color = 'red';


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
plot(datetime(time_vec_temp), angle_temp - middle_temp * isCst_temp, 'Color', line_color)
xtickangle(90);
ylabel('Inclination [deg]')
if isCst_temp, ylabel({gca().YLabel.String, ['around ', num2str(middle_temp, '%.2f')]}); end
xlabel('Time')
xticksCustomDate();
betterYLim(OE.i - middle_temp * isCst_temp, 0.1, 0 - isCst_temp * 360, 90);

if par.PRINT_PDF
    fig2pdf(gcf, 'OE_i', fig_size, fig_AR, par.PDF_FOLDER)
end
fig_ax.i = gca;

%% RAAN
[time_vec_temp, angle_temp] = angleDiscon(time_vec, OE.RAAN);
[isCst_temp, middle_temp] = plotConstant(angle_temp, 1e-3);
figure('Name', 'OE: RAAN', 'WindowStyle', 'docked');
plot(datetime(time_vec_temp), angle_temp - middle_temp * isCst_temp, 'Color', line_color)
xtickangle(90);
ylabel('RAAN \Omega [deg]')
if isCst_temp, ylabel({gca().YLabel.String, ['around ', num2str(middle_temp, '%.2f')]}); end
xlabel('Time')
xticksCustomDate();
betterYLim(OE.RAAN - middle_temp * isCst_temp, 0.1, 0 - isCst_temp * 360, 360);

if par.PRINT_PDF
    fig2pdf(gcf, 'OE_RAAN', fig_size, fig_AR, par.PDF_FOLDER)
end
fig_ax.RAAN = gca;

%% Eccentricity
[isCst_temp, middle_temp] = plotConstant(OE.ecc, 1e-3);
figure('Name', 'OE: ecc', 'WindowStyle', 'docked');
plot(datetime(time_vec), OE.ecc - middle_temp * isCst_temp, 'Color', line_color)
xtickangle(90);
ylabel('Eccentricity [-]')
if isCst_temp, ylabel({gca().YLabel.String, ['around ', num2str(middle_temp, '%.2e')]}); end
xlabel('Time')
xticksCustomDate();
betterYLim(OE.ecc - middle_temp * isCst_temp, 0.1, 0 - isCst_temp * 1, 1);

if par.PRINT_PDF
    fig2pdf(gcf, 'OE_ecc', fig_size, fig_AR, par.PDF_FOLDER)
end
fig_ax.ecc = gca;

%% Argument of perigee (omega)
[time_vec_temp, angle_temp] = angleDiscon(time_vec, OE.omega);
[isCst_temp, middle_temp] = plotConstant(angle_temp, 1e-3);
figure('Name', 'OE: omega', 'WindowStyle', 'docked');
plot(datetime(time_vec_temp), angle_temp - middle_temp * isCst_temp, 'Color', line_color)
xtickangle(90);
ylabel('Argument of perigee \omega [deg]')
if isCst_temp, ylabel({gca().YLabel.String, ['around ', num2str(middle_temp, '%.2f')]}); end
xlabel('Time')
xticksCustomDate();
ylim([0, 360])
betterYLim(OE.omega - middle_temp * isCst_temp, 0.1, 0 - isCst_temp * 360, 360);

if par.PRINT_PDF
    fig2pdf(gcf, 'OE_omega', fig_size, fig_AR, par.PDF_FOLDER)
end
fig_ax.omega = gca;

%% True anomaly (theta)
[time_vec_temp, angle_temp] = angleDiscon(time_vec, OE.theta);
[isCst_temp, middle_temp] = plotConstant(angle_temp, 1e-3);
figure('Name', 'OE: theta', 'WindowStyle', 'docked');
plot(datetime(time_vec_temp), angle_temp - middle_temp * isCst_temp, 'Color', line_color)
xtickangle(90);
ylabel('True anomaly \theta [deg]')
if isCst_temp, ylabel({gca().YLabel.String, ['around ', num2str(middle_temp, '%.2f')]}); end
xlabel('Time')
xticksCustomDate();
betterYLim(OE.theta - middle_temp * isCst_temp, 0.1, 0 - isCst_temp * 360, 360);
yticks(0:45:360);

if par.PRINT_PDF
    fig2pdf(gcf, 'OE_theta', fig_size, fig_AR, par.PDF_FOLDER)
end
fig_ax.theta = gca;

%% Semi major axis
[isCst_temp, middle_temp] = plotConstant(OE.a /1000, 1e-3);
figure('Name', 'OE: a', 'WindowStyle', 'docked');
plot(datetime(time_vec), OE.a /1000 - middle_temp * isCst_temp, 'Color', line_color)
xtickangle(90);
ylabel('Semi-major axis [km]')
if isCst_temp, ylabel({gca().YLabel.String, ['around ', num2str(middle_temp, '%.2f')]}); end
xlabel('Time')
xticksCustomDate();
betterYLim(OE.a /1000 - middle_temp * isCst_temp, 0.1, par.pdata.earth.radius /1000 - isCst_temp * 2 * par.pdata.earth.radius /1000, 1e20);

if par.PRINT_PDF
    fig2pdf(gcf, 'OE_a', fig_size, fig_AR, par.PDF_FOLDER)
end
fig_ax.a = gca;

%% Altitude
figure('Name', 'Altitude', 'WindowStyle', 'docked');
plot(datetime(time_vec), LLA(:,3) /1000, 'Color', line_color)
xtickangle(90);
ylabel('Altitude [km]')
xlabel('Time')
xticksCustomDate();
betterYLim(LLA(:,3) /1000, 0.1, 0, 1e20);

if par.PRINT_PDF
    fig2pdf(gcf, 'altitude', fig_size, fig_AR, par.PDF_FOLDER)
end
fig_ax.altitude = gca;

end

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

