import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import ode
from mpl_toolkits.mplot3d import Axes3D
plt.style.use('dark_background')

def plot(rs):
    # 3D Plot
    fig = plt.figure(figsize=(10,10))
    ax = fig.add_subplot(111,projection = '3d')
    
    # Plot trajectory and starting point
    ax.plot(rs[:,0],rs[:,1],rs[:,2],'w',label ='Trajectory')
    ax.plot([rs[0,0]],[rs[0,1]],[rs[0,2]],'wo',label='Initial Position')
    
    # plot earth
    _u,_v = np.mgrid[0:2*np.pi:40j,0:np.pi:40j]
    _x = earth_radius*np.cos(_u)*np.sin(_v)
    _y = earth_radius*np.sin(_u)*np.sin(_v)
    _z = earth_radius*np.cos(_v)
    ax.plot_surface(_x,_y,_z,cmap='Blues')
    
    # Plot the x,y,z vectors
    l = earth_radius*2
    x,y,z = [[0,0,0],[0,0,0],[0,0,0]]
    u,v,w = [[l,0,0],[0,l,0],[0,0,l]]
    ax.quiver(x,y,z,u,v,w,color='k')
    
    # check for custom axes limits
    max_val = np.max(np.abs(rs))
    
    # Set label and title
    ax.set_xlim([-max_val,max_val])
    ax.set_ylim([-max_val,max_val])
    ax.set_zlim([-max_val,max_val])
    ax.set_xlabel('X (km)')
    ax.set_ylabel('Y (km)')
    ax.set_zlabel('Z (km)')
    # ax.set_aspect('equal')
    
    # ax.plot_title('Test')
    plt.legend()
    plt.show()

earth_radius = 6378.0   # km
earth_mu = 398600       # km^3/s^2

def diffy_q(t,y,mu):
    # unpack state
    rx,ry,rz,vx,vy,vz=y
    r = np.array([rx,ry,rz])
    
    # norm if the radius vector
    norm_r = np.linalg.norm(r)
    
    # Two body acceleration
    ax,ay,az = -r*mu/norm_r**3
    
    return[vx,vy,vz,ax,ay,az]


    
if __name__ == '__main__':
    # initial condition of orbit parameters
    r_mag = earth_radius + 1500          # km
    v_mag = 10 # np.sqrt(earth_mu/r_mag)     # km/s
    
    # initial position and velocity vector
    r0 = [r_mag,0,0]
    v0 = [0,v_mag,0]
    
    # time span
    tspan = 100*24*3600
    
    # Time step
    dt = 100
    
    # Total number of steps
    n_steps = int(np.ceil(tspan/dt))
    
    # Initialize arrays
    ys = np.zeros((n_steps,6))
    ts = np.zeros((n_steps,1))
    
    # Initial conditions
    y0 = r0+v0
    ys[0] = np.array(y0)
    step = 1
    
    # initiate solver
    solver = ode(diffy_q)
    solver.set_integrator('lsoda')
    solver.set_initial_value(y0,0)
    solver.set_f_params(earth_mu)
    
    
    # Propagate orbit
    while solver.successful() and step < n_steps:
        solver.integrate(solver.t+dt)
        ts[step] = solver.t
        ys[step] = solver.y
        step += 1
        
    rs = ys[:,:3]
    
    plot(rs)
        
    