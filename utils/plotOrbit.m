function [ECEF_out, fig_ax] = plotOrbit(par, time, ECI, comparison)
% PLOTORBIT Represents the orbit in different ways
%   

    %% 3D plot
    plot_3D(par.pdata.earth.radius, ECI);
    fig_ax.plot_3D = gca;
    
    %% Conversion to ECEF
    if nargin == 4
        % adding comparison
        time = [time; NaN; time];
        vec = time_conversion(time, par.Orb_elem0.utc_jd);
        ECI = [ECI; [NaN, NaN, NaN, NaN, NaN, NaN]; comparison];
        
        % converting to ECEF
        ECEF = ECEF_conversion(par, ECI, vec);

        % output can't contain comparison
        ECEF_out = ECEF(1:(size(vec, 1)-1)/2, :);

    else
        % no comparison
        vec = time_conversion(time, par.Orb_elem0.utc_jd);
        ECEF = ECEF_conversion(par, ECI, vec);
        ECEF_out = ECEF;

    end
    
    %% Using the groundtrack function
    grdtrk(ECEF(:,1:3));
    fig_ax.ground_track = gca;

end

function vec = time_conversion(time, jd)
% TIME_CONVERSION 
%

    time_jd = time /86400 + jd; % adding epoch
    dt = datetime(time_jd, 'ConvertFrom', 'juliandate', 'TimeZone', 'UTC'); % to UTC vec
    vec = datevec(dt); % eci2ecef only takes vectors

end

function ECEF_converted = ECEF_conversion(par, ECI, vec)
% ECEF_CONVERTED 
%

    if par.DEBUG
        disp('Converting result to ECEF... (this operation is very slow)')
    end
    
    tic
    ECEF_converted = zeros(size(vec, 1), 3);
    for i = 1:size(vec, 1)
        if ~isnan(vec(i,:))
            r = eci2ecef(vec(i,:), ECI(i,1:3));
            ECEF_converted(i,:) = r'; % contains both position and velocity
        else
            ECEF_converted(i,:) = [NaN, NaN, NaN];
        end
    end
    toc

end