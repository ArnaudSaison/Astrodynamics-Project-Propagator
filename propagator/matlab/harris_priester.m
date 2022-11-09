function rho = harris_priester(r, par ,T)
    % rho send the resulting density following Harris-Priester model
    % Orbital parameters of the sun
    epsilon = deg2rad(23.43929111);          % rad
    M = mod(357.5256+35999.049*T,360);       % deg

    Ecliptic_Lon = mod(par.pdata.sun.omega_o + deg2rad(M) + 6892/3600*sin(deg2rad(M)) ...
        + 72/3600*sin(deg2rad(2*M)) + deg2rad(1.972)*T,2*pi);       % rad
    
    RA = atan2(cos(epsilon)*sin(Ecliptic_Lon),cos(Ecliptic_Lon));   % rad
    SD = asin(sin(deg2rad(-23.44))*sin(Ecliptic_Lon));              % rad

    u_b = [cos(SD)*cos(RA+par.pdata.sun.lag)...
          ,cos(SD)*sin(RA+par.pdata.sun.lag)...
          ,sin(SD)];

    norm_r = norm(r);

    n = 2; % for low inclination orbit
    angle_vector_bulge = (0.5+(r'*u_b')/(2*norm_r))^(n/2);

    h = norm_r-par.pdata.earth.radius;

    for n = drange(1:48-1) 
        if  h < par.pdata.atmo(n+1,1) & h > par.pdata.atmo(n,1)
            h = [par.pdata.atmo(n,1),h,par.pdata.atmo(n+1,1)];
            rho_m = [par.pdata.atmo(n,2),0,par.pdata.atmo(n+1,2)];
            rho_M = [par.pdata.atmo(n,3),0,par.pdata.atmo(n+1,3)];
        end
    end
    
    H_mi = (h(1)-h(3))/(log(rho_m(3)/rho_m(1)));
    H_Mi = (h(1)-h(3))/(log(rho_M(3)/rho_M(1)));
    
    rho_m(2) = rho_m(1)*exp((h(1)-h(2))/H_mi);
    rho_M(2) = rho_M(1)*exp((h(1)-h(2))/H_Mi);

    % Return density
    rho = rho_m(2)+(rho_M(2)-rho_m(2))*angle_vector_bulge;
end