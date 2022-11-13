function [ECEF_out, LLA_out, fig_ax] = plotOrbit(par, time, ECI, comparison)
% PLOTORBIT Represents the orbit in different ways
%   

    %% 3D plot
    plot_3D(par.pdata.earth.radius, ECI, 'ECI');
    fig_ax.plot_3D = gca;

    if par.PRINT_PDF
        fig2pdf(gcf, '3D_plot_ECI', 1, 1.5, par.PDF_FOLDER)
    end
    
    %% Conversion to ECEF
    if nargin == 4
        % adding comparison
        time = [time; NaN; time];
        time_vec = time_conversion(time, par.Orb_elem0.utc_jd);
        ECI = [ECI; [NaN, NaN, NaN, NaN, NaN, NaN]; comparison];
        
        % converting to ECEF
        ECEF = ECEF_conversion(par, ECI, time_vec);

        % output can't contain comparison
        ECEF_out = ECEF(1:(size(time_vec, 1)-1)/2, :);

    else
        % no comparison
        time_vec = time_conversion(time, par.Orb_elem0.utc_jd);
        ECEF = ECEF_conversion(par, ECI, time_vec);
        ECEF_out = ECEF;

    end

    %% Converting to LLA
    % finding lla (latitude longitude altitude)
    % /!\ S3L ouputs altitude longitude latitude
    LLA_out = ecef2lla(ECEF_out);
    
    %% Using the groundtrack function
    grdtrk(ECEF(:,1:3));
    fig_ax.ground_track = gca;

    if par.PRINT_PDF
        fig2pdf(gcf, 'ground_track', 1, 1.5, par.PDF_FOLDER)
    end

    %% 3D plot
    plot_3D(par.pdata.earth.radius, ECEF, 'ECEF');
    fig_ax.plot_3D = gca;

    if par.PRINT_PDF
        fig2pdf(gcf, '3D_plot_ECEF', 1, 1.5, par.PDF_FOLDER)
    end

end

function vec = time_conversion(time, jd)
% TIME_CONVERSION 
%

    time_jd = time /86400 + jd; % adding epoch
    dt = datetime(time_jd, 'ConvertFrom', 'juliandate', 'TimeZone', 'UTC'); % to UTC vec
    vec = datevec(dt); % eci2ecef only takes vectors

end

function ECEF_converted = ECEF_conversion(par, ECI, time_vec)
% ECEF_CONVERTED 
%

    if par.DEBUG
        disp('Converting result to ECEF... (this operation is very slow)')
    end
    
    tic
    ECEF_converted = zeros(size(time_vec, 1), 3);
    for i = 1:size(time_vec, 1)
        if ~isnan(time_vec(i,:))
            r = eci2ecef(time_vec(i,:), ECI(i,1:3));
            ECEF_converted(i,:) = r'; % contains both position and velocity
        else
            ECEF_converted(i,:) = [NaN, NaN, NaN];
        end
    end
    toc

end