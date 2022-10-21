function dqdt = propagator(t,state)
    r = state(1:3);
    norm_r = norm(r);

    % Two body acceleration
    mu = 398600;
    acc = -r.*(mu/norm_r^3);
    
    % Return derivative vectors
    dqdt = [state(4:6);acc];
end