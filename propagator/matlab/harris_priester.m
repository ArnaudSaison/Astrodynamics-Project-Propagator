function rho = harris_priester(r, par , T, r_LLA)
    % harris_priester calculates the density depending on position and
    % altitude
    % 
    % Inputs:
    %   r = position [x, y, z]
    %   par = all parameters
    %   T = precalculated time for Harris-Priester calculation
    % 
    % Outputs:
    %   rho =  density
    % 

    % Orbital parameters of the sun
    epsilon = deg2rad(23.43929111);         % rad
    M = 357.5256+35999.049*T;               % deg

    Lambda_sun = deg2rad(mod(rad2deg(par.pdata.sun.omega_o) + M + 6892/3600*sind(M) ...
        + 72/3600*sind(2*M) + 1.972*T,360));       % rad
    
    % Sun right ascension
    RA = atan2(cos(epsilon)*sin(Lambda_sun),cos(Lambda_sun));   % rad

    % Sun declination
    SD = asin(sin(epsilon)*sin(Lambda_sun)); % rad

    % unit vector of the apex diurnal
    u_b = [cos(SD)*cos(RA+par.pdata.sun.lag)...
          ,cos(SD)*sin(RA+par.pdata.sun.lag)...
          ,sin(SD)];

    norm_r = norm(r);

    n = par.prop.n;
    angle_vector_bulge = (0.5+(r'*u_b')/(2*norm_r))^(n/2);
    
    h = r_LLA(3);
    
    % all parameters below use a matrix 1x3
    % in the form [min current max]

    % select the right atmo height
    for n = drange(1:48-1) 
        if  h < par.pdata.atmo(n+1,1) & h > par.pdata.atmo(n,1)
            h = [par.pdata.atmo(n,1),h,par.pdata.atmo(n+1,1)];
            rho_m = [par.pdata.atmo(n,2),0,par.pdata.atmo(n+1,2)];
            rho_M = [par.pdata.atmo(n,3),0,par.pdata.atmo(n+1,3)];
        end
    end
    
    % Scale height
    H_mi = (h(1)-h(3))/(log(rho_m(3)/rho_m(1)));
    H_Mi = (h(1)-h(3))/(log(rho_M(3)/rho_M(1)));

    % Calculate the min and max density for the selected height
    rho_m(2) = rho_m(1)*exp((h(1)-h(2))/H_mi);
    rho_M(2) = rho_M(1)*exp((h(1)-h(2))/H_Mi);

    % Return density
    rho = rho_m(2)+(rho_M(2)-rho_m(2))*angle_vector_bulge;
end