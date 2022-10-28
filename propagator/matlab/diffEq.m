function dqdt = diffEq(t, state, par)
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

    % J2 component (if activated)
    if par.ENABLE_J2
        temp1 = (5 * (r(3)/norm_r).^2 - 1)/norm_r^3;
        acc = acc + 3/2 * mu * par.pdata.earth.J2 * (par.pdata.earth.radius/norm_r)^2 * r .* [temp1; temp1; temp1 - 2/norm_r^3];
    end
    
    % Return derivative vectors
    dqdt = [state(4:6);acc];
end