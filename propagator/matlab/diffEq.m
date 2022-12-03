function dqdt = diffEq(Time, state, par)
% DIFFEQ represents the differencial equation to solve
% 
% Inputs:
%   Time = Time from start of calculation
%   state = [x, y, z, x_dot, y_dot, z_dot]
%   par = all parameters
% 
% Outputs:
%   dqdt = [x_dot, y_dot, z_dot, acc_x, acc_y, acc_z]
% 
    
    % retrieving parameter
    mu = par.pdata.earth.mu;

    % preparing r (= x 1_x + y 1_y + z 1_z)
    r = state(1:3); % column vector
    norm_r = norm(r);

    % Two body acceleration
    acc = -r.*(mu/norm_r^3);
    
    if par.ENABLE_J2 || par.ENABLE_DRAG
        % to take convert to ECEF frame (because potential in that frame),
        % we need the time
        J2_time_jd = Time /86400 + par.Orb_elem0.utc_jd; % adding epoch to time
        J2_dt = datetime(J2_time_jd, 'ConvertFrom', 'juliandate', 'TimeZone', 'UTC'); % to UTC vec
        J2_time_vec = datevec(J2_dt); % eci2ecef only takes vectors

        % reference frame conversion to ECEF
        r_ECEF = eci2ecef(J2_dt, r);
        norm_r_ECEF = norm(r_ECEF); % new norm
    end


    % J2 component (if activated)
    if par.ENABLE_J2
        % computating the perturbation
        temp1 = (5 * (r_ECEF(3)/norm_r_ECEF).^2 - 1)/norm_r_ECEF^3;
        acc_J2 = 3/2 * mu * par.pdata.earth.J2 * (par.pdata.earth.radius/norm_r_ECEF)^2 * r_ECEF .* [temp1; temp1; temp1 - 2/norm_r_ECEF^3];
        
        % back to ECI reference frame
        acc_J2 = ecef2eci(J2_dt, acc_J2);

        % adding contribution
        acc = acc + acc_J2;
    end

    % Drag component (if activated)
    % Time increments
    T = (J2_time_jd-2451545)/36525;

    if par.ENABLE_DRAG
        r_LLA = ecef2lla(r_ECEF');

        % calculate the atmosphere density
        rho = harris_priester(r,par,T,r_LLA);
        
        % extract speed from state variable
        v_sat = state(4:6);
        v_rel = v_sat - cross(par.pdata.earth.atm_rot',r);
        
        % compute drag force
        drag = -0.5*norm(v_rel)*v_rel*rho*par.prop.A*par.prop.CD;
        acc_drag = drag/par.prop.MASS;

        % adding contribution
        acc = acc + acc_drag;
    end
    
    % Return derivative vectors
    dqdt = [state(4:6);acc];
end