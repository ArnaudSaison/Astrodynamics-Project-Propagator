function rho = harris_priester(r, par)
% rho send the resulting density following Harris-Priester model
    norm_r = norm(r);

    n = 2; % for low inclination orbit
    angle_vector_bulge = (0.5+(r'*par.sun.u_b')/(2*norm_r))^(n/2);

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