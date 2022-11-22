function dqdt = diffEq(Time, state, par)
% DIFFEQ represents the differencial equation to solve
%   state = [x, y, z, x_dot, y_dot, z_dot]
% 
    
    % retrieving parameter
    mu = par.pdata.earth.mu;

    % preparing r (= x 1_x + y 1_y + z 1_z)
    r = state(1:3); % column vector
    norm_r = norm(r);

    % Two body acceleration
    acc = -r.*(mu/norm_r^3);
    
    % Time increments
    T = (par.Orb_elem0.utc_jd-2451545+(Time/86400))/36525;
    
    % J2 component (if activated)
    if par.ENABLE_J2
        % to take convert to ECEF frame (because potential in that frame),
        % we need the time
        J2_time_jd = Time /86400 + par.Orb_elem0.utc_jd; % adding epoch to time
        J2_dt = datetime(J2_time_jd, 'ConvertFrom', 'juliandate', 'TimeZone', 'UTC'); % to UTC vec
        J2_time_vec = datevec(J2_dt); % eci2ecef only takes vectors

        % reference frame conversion to ECEF
        r_ECEF = eci2ecef(J2_time_vec, r);
        norm_r_ECEF = norm(r_ECEF); % new norm

        % computating the perturbation
        temp1 = (5 * (r_ECEF(3)/norm_r_ECEF).^2 - 1)/norm_r_ECEF^3;
        acc_J2 = 3/2 * mu * par.pdata.earth.J2 * (par.pdata.earth.radius/norm_r_ECEF)^2 * r_ECEF .* [temp1; temp1; temp1 - 2/norm_r_ECEF^3];
        
        % back to ECI reference frame
        acc_J2 = ecef2eci(J2_time_vec, acc_J2);

        % adding contribution
        acc = acc + acc_J2;

    end

    % Drag component (if activated)
    if par.ENABLE_DRAG
        rho = harris_priester(r,par,T);
        v_sat = state(4:6);
        drag = -0.5*norm(v_sat)*v_sat*rho*par.prop.A*par.prop.CD;
        acc = acc + drag/par.prop.MASS;
    end
    
    % Return derivative vectors
    dqdt = [state(4:6);acc];
end