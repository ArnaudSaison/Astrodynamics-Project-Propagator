function plotOE(par, time, time_vec, OE)
%PLOTOE plots the orbital elements
%   
fig_size = 1.5;
fig_AR = 1.5;

%% Inclination variation
% useful when inclination is not supposed to changed
figure('Name', 'OE: i variation', 'WindowStyle', 'docked');
plot(datetime(time_vec), OE.i - OE.i(1))
xtickangle(90);
ylabel(['Variation of i around ', num2str(OE.i(1), '%.2f'), '° [deg]'])
xlabel('Time')
xticksCustomDate();

% print to PDF
if par.PRINT_PDF
    fig2pdf(gcf, 'OE_i_variation', fig_size, fig_AR, par.PDF_FOLDER)
end

%% Inclination
figure('Name', 'OE: i', 'WindowStyle', 'docked');
plot(datetime(time_vec), OE.i)
xtickangle(90);
ylabel('Inclination [deg]')
xlabel('Time')
xticksCustomDate();
ylim([0, 90])

if par.PRINT_PDF
    fig2pdf(gcf, 'OE_i', fig_size, fig_AR, par.PDF_FOLDER)
end

%% RAAN
figure('Name', 'OE: RAAN', 'WindowStyle', 'docked');
plot(datetime(time_vec), OE.RAAN)
xtickangle(90);
ylabel('RAAN \Omega [deg]')
xlabel('Time')
xticksCustomDate();
ylim([min(OE.RAAN) - 1, max(OE.RAAN) + 1])

if par.PRINT_PDF
    fig2pdf(gcf, 'OE_RAAN', fig_size, fig_AR, par.PDF_FOLDER)
end

%% Eccentricity
figure('Name', 'OE: ecc', 'WindowStyle', 'docked');
plot(datetime(time_vec), OE.ecc)
xtickangle(90);
ylabel('Eccentricity [-]')
xlabel('Time')
xticksCustomDate();
ylim([0, min(max(OE.ecc) * 2, 1)]);

if par.PRINT_PDF
    fig2pdf(gcf, 'OE_ecc', fig_size, fig_AR, par.PDF_FOLDER)
end

%% Argument of perigee (omega)
figure('Name', 'OE: omega', 'WindowStyle', 'docked');
plot(datetime(time_vec), OE.omega)
xtickangle(90);
ylabel('Argument of periapsis \omega [deg]')
xlabel('Time')
xticksCustomDate();
ylim([0, 360])
yticks(0:45:360);

if par.PRINT_PDF
    fig2pdf(gcf, 'OE_omega', fig_size, fig_AR, par.PDF_FOLDER)
end

%% True anomaly (theta)
figure('Name', 'OE: theta', 'WindowStyle', 'docked');
plot(datetime(time_vec), OE.theta)
xtickangle(90);
ylabel('True anomaly \theta [deg]')
xlabel('Time')
xticksCustomDate();
ylim([0, 360])
yticks(0:45:360);

if par.PRINT_PDF
    fig2pdf(gcf, 'OE_theta', fig_size, fig_AR, par.PDF_FOLDER)
end

%% Semi major axis
figure('Name', 'OE: a', 'WindowStyle', 'docked');
plot(datetime(time_vec), OE.a /1000)
xtickangle(90);
ylabel('Semi major axis [km]')
xlabel('Time')
xticksCustomDate();
%ylim([par.pdata.earth.radius, (max(OE.a) - par.pdata.earth.radius) * 1.1 + par.pdata.earth.radius])
ylim([min(OE.a /1000) - 5, max(OE.a /1000) + 5])

if par.PRINT_PDF
    fig2pdf(gcf, 'OE_a', fig_size, fig_AR, par.PDF_FOLDER)
end



end

