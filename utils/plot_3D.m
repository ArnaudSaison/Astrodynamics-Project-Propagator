function plot_3D(earth_radius, stateout, type)
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
    fig = figure('Name', '3D plot');
    set(fig,'color','white');
    plot3(xout, yout, zout,'r-', 'LineWidth', 1, 'DisplayName', 'orbit');
    hold on;

    % end marker
    scatter3(xout(end), yout(end), zout(end), 150, ...
        'MarkerEdgeColor', 'black', ...
        'MarkerFaceColor', 'magenta', ...
        'Marker','square', ...
        'LineWidth', 2, ...
        'DisplayName', 'End');
    hold on;

    % start marker
    scatter3(xout(1), yout(1), zout(1), 150, ...
        'MarkerEdgeColor', 'black', ...
        'MarkerFaceColor', 'cyan', ...
        'Marker','square', ...
        'LineWidth', 2, ...
        'DisplayName', 'Start');
    hold on;

    % legend and labels
    legend();
    xlabel('x [m]');
    ylabel('y [m]');
    zlabel('z [m]');
    grid on;

    % Earth representation
    surf(X, Y, Z ,'EdgeColor', 'none', 'DisplayName', ['Earth (', type, ')']);
    colormap winter;
    axis equal;
end