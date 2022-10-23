function plot_3D(earth_radius,stateout)
    % Make Earth
    [X,Y,Z] = sphere;
    X = X*earth_radius;
    Y = Y*earth_radius;
    Z = Z*earth_radius;
    
    % State vector
    xout = stateout(:,1);
    yout = stateout(:,2);
    zout = stateout(:,3);
    
    % Plot 3D
    fig = figure();
    set(fig,'color','white')
    plot3(xout,yout,zout,'b-','LineWidth',4)
    grid on
    hold on
    surf(X,Y,Z,'EdgeColor','none')
    axis equal;
end