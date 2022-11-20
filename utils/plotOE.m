function plotOE(par, time, time_vec, OE, LLA)
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
figure('Name', 'OE: i', 'WindowStyle', 'docked');
plot(datetime(time_vec_temp), angle_temp, 'Color', line_color)
xtickangle(90);
ylabel('Inclination [deg]')
xlabel('Time')
xticksCustomDate();
betterYLim(OE.i, 0.1, 0, 90);

if par.PRINT_PDF
    fig2pdf(gcf, 'OE_i', fig_size, fig_AR, par.PDF_FOLDER)
end

%% RAAN
[time_vec_temp, angle_temp] = angleDiscon(time_vec, OE.RAAN);
figure('Name', 'OE: RAAN', 'WindowStyle', 'docked');
plot(datetime(time_vec_temp), angle_temp, 'Color', line_color)
xtickangle(90);
ylabel('RAAN \Omega [deg]')
xlabel('Time')
xticksCustomDate();
betterYLim(OE.RAAN, 0.1, 0, 360);

if par.PRINT_PDF
    fig2pdf(gcf, 'OE_RAAN', fig_size, fig_AR, par.PDF_FOLDER)
end

%% Eccentricity
figure('Name', 'OE: ecc', 'WindowStyle', 'docked');
plot(datetime(time_vec), OE.ecc, 'Color', line_color)
xtickangle(90);
ylabel('Eccentricity [-]')
xlabel('Time')
xticksCustomDate();
betterYLim(OE.ecc, 0.1, 0, 1);

if par.PRINT_PDF
    fig2pdf(gcf, 'OE_ecc', fig_size, fig_AR, par.PDF_FOLDER)
end

%% Argument of perigee (omega)
[time_vec_temp, angle_temp] = angleDiscon(time_vec, OE.omega);
figure('Name', 'OE: omega', 'WindowStyle', 'docked');
plot(datetime(time_vec_temp), angle_temp, 'Color', line_color)
xtickangle(90);
ylabel('Argument of periapsis \omega [deg]')
xlabel('Time')
xticksCustomDate();
ylim([0, 360])
yticks(0:45:360);
betterYLim(OE.omega, 0.1, 0, 360);

if par.PRINT_PDF
    fig2pdf(gcf, 'OE_omega', fig_size, fig_AR, par.PDF_FOLDER)
end

%% True anomaly (theta)
[time_vec_temp, angle_temp] = angleDiscon(time_vec, OE.theta);
figure('Name', 'OE: theta', 'WindowStyle', 'docked');
plot(datetime(time_vec_temp), angle_temp, 'Color', line_color)
xtickangle(90);
ylabel('True anomaly \theta [deg]')
xlabel('Time')
xticksCustomDate();
betterYLim(OE.theta, 0.1, 0, 360);
yticks(0:45:360);

if par.PRINT_PDF
    fig2pdf(gcf, 'OE_theta', fig_size, fig_AR, par.PDF_FOLDER)
end

%% Semi major axis
figure('Name', 'OE: a', 'WindowStyle', 'docked');
plot(datetime(time_vec), OE.a /1000, 'Color', line_color)
xtickangle(90);
ylabel('Semi major axis [km]')
xlabel('Time')
xticksCustomDate();
betterYLim(OE.a /1000, 0.1, par.pdata.earth.radius /1000, 1e20);

if par.PRINT_PDF
    fig2pdf(gcf, 'OE_a', fig_size, fig_AR, par.PDF_FOLDER)
end


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

end

