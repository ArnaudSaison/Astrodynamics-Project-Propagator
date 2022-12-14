function plot_3D(earth_radius, stateout, type, time_vec)
    % Make Earth
    [X, Y, Z] = sphere;

    X = X * earth_radius;
    Y = Y * earth_radius;
    Z = Z * earth_radius;
    
    % State vector
    xout = stateout(:,1);
    yout = stateout(:,2);
    zout = stateout(:,3);
    
    % Plot 3D
    fig = figure('Name', '3D plot', 'WindowStyle', 'docked');
    set(fig,'color','white');
    plot3(xout, yout, zout,'r-', 'LineWidth', 1, ...
          'DisplayName', 'orbit');
          %'DisplayName', ['orbit after', num2str(t_end /24/3600, '%.1f'), ' day(s)']);
    hold on;

    % end marker
    scatter3(xout(end), yout(end), zout(end), 150, ...
        'MarkerEdgeColor', 'black', ...
        'MarkerFaceColor', 'cyan', ...
        'Marker', 'square', ...
        'LineWidth', 2, ...
        'DisplayName', ['End (', char(datetime(time_vec(end,:))), ')']);
    hold on;

    % start marker
    scatter3(xout(1), yout(1), zout(1), 150, ...
        'MarkerEdgeColor', 'black', ...
        'MarkerFaceColor', 'r', ...
        'Marker', 'square', ...
        'LineWidth', 2, ...
        'DisplayName', ['Start (', char(datetime(time_vec(1,:))), ')']);
    hold on;

    % legend and labels
    legend('Location', 'northoutside');
    xlabel('x [m]');
    ylabel('y [m]');
    zlabel('z [m]');
    grid on;

    % Earth representation
    surf(X, Y, Z ,'EdgeColor', 'none', 'DisplayName', ['Earth (', type, ')']);
    colormap winter;
    axis equal;
end