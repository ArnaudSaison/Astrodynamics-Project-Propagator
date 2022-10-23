function dqdt = diffEq(t,state, mu)
% DIFFEQ represents the differencial equation to solve
%   state = [x, y, z, x_dot, y_dot, z_dot]
% 

    r = state(1:3);
    norm_r = norm(r);

    % Two body acceleration
    acc = -r.*(mu/norm_r^3);
    
    % Return derivative vectors
    dqdt = [state(4:6);acc];
end