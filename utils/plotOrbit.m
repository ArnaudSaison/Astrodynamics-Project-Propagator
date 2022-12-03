function [fig_ax] = plotOrbit(par, time, time_vec, ECI, ECEF, OE, LLA, AN)
% PLOTORBIT Represents the orbit in different ways
%   
    
    %% Using the groundtrack function
    LLA_grdtrk = grdtrk(ECEF(:,1:3), time_vec);
    fig_ax.ground_track = gca;
    fig_ax.LLA_grdtrk = LLA_grdtrk;

    if par.PRINT_PDF
        fig2pdf(gcf, 'ground_track', 1.5, 1.5, par.PDF_FOLDER)
    end

    %% 3D plot ECI
    plot_3D(par.pdata.earth.radius, ECI, 'ECI', time_vec);
    fig_ax.plot_3D = gca;

    if par.PRINT_PDF
        fig2pdf(gcf, '3D_plot_ECI', 2, 0.9, par.PDF_FOLDER)
    end
    
    %% 3D plot ECEF
    plot_3D(par.pdata.earth.radius, ECEF, 'ECEF', time_vec);
    fig_ax.plot_3D = gca;
    
    if par.PRINT_PDF
        fig2pdf(gcf, '3D_plot_ECEF', 2, 0.9, par.PDF_FOLDER)
    end

    %% plot of the orbital elements
    fig_ax.OE = plotOE(par, time, time_vec, OE, LLA); % (prints to pdf included)
    
end