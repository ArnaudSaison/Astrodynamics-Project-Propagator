import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import math as m

import Planetary_data as pd

d2r = np.pi/180


def plot_n_orbits(rs, labels, cb=pd.earth, show_plot=False, save_plot=False, title='Test Title'):
    # 3D Plot
    fig = plt.figure(figsize=(10,10))
    ax = fig.add_subplot(111,projection = '3d')

    # Plot trajectory and starting point
    n=0
    for r in rs:
        ax.plot(r[:,0],r[:,1],r[:,2],label = labels[n],zorder=5)
        ax.plot([r[0,0]],[r[0,1]],[r[0,2]],zorder=5)
        n+=1

    # plot earth
    _u,_v = np.mgrid[0:2*np.pi:40j,0:np.pi:40j]
    _x = cb['radius']*np.cos(_u)*np.sin(_v)
    _y = cb['radius']*np.sin(_u)*np.sin(_v)
    _z = cb['radius']*np.cos(_v)
    ax.plot_surface(_x,_y,_z,cmap='Blues',zorder=0)

    # Plot the x,y,z vectors
    l = cb['radius']*2
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

    ax.set_title(title)
    plt.legend()
    if show_plot:
        plt.show()
    if save_plot:
        plt.savefig(title+'png',dpi=300)
        
def coes2rv(coes,deg=False,mu=pd.earth['mu']):
    a,e,i,ta,aop,raan=coes
    if deg:
        i*=d2r
        ta*=d2r
        aop*=d2r
        raan*=d2r
    
    E = ecc_anomaly([ta,e],'tae')
    
    r_norm = a*(1-e**2)/(1+e*np.cos(ta))
    
    # calculate r and v vector in perifocal frame
    r_perif = r_norm*np.array([m.cos(ta),m.sin(ta),0])
    v_perif = m.sqrt(mu*a)/r_norm*np.array([-m.sin(E),m.cos(E)*m.sqrt(1-e**2),0])
                                           
    # rotation matrx from perifocal to ECI
    perif2eci = np.transpose(eci2perif(raan,aop,i))
    
    # calculate r and v vector to inertial frame
    r = np.dot(perif2eci,r_perif)
    v = np.dot(perif2eci,v_perif)
    
    return r,v   

def eci2perif(raan,aop,i):
    row0=[-m.sin(raan)*m.cos(i)*m.sin(aop)+m.cos(raan)*m.cos(aop),m.cos(raan)*m.cos(i)*m.sin(aop)+m.sin(raan)*m.cos(aop),m.sin(i)*m.sin(aop)]
    row1=[-m.sin(raan)*m.cos(i)*m.cos(aop)-m.cos(raan)*m.sin(aop),m.cos(raan)*m.cos(i)*m.cos(aop)-m.sin(raan)*m.sin(aop),m.sin(i)*m.cos(aop)]
    row2=[m.sin(raan)*m.sin(i),-m.cos(raan)*m.sin(i),m.cos(i)]
    return np.array([row0,row1,row2])

# calculate eccentric anomaly (E)
def ecc_anomaly(arr,method,tol=1e-8):
    if method == 'newton':
        # newton's method for iteratively finding E
        Me,e = arr
        
        if Me < np.pi/2.0: E0=Me+e/2.0
        else: E0=Me-e
        
        for n in range(200): # arbitrary max number of steps
            ratio=(E0-e*np.sin(E0)-Me)/(1-e*np.cos(E0))
            if abs(ratio)<tol:
                if n==0: return E0
                else: return E1
            else:
                E1=E0-ratio
                E0=E1
        # did not converge
        return False
    elif method == 'tae':
        ta,e=arr
        return 2*m.atan(m.sqrt((1-e)/(1+e))*m.tan(ta/2.0))
    else:
        print('Invalid method for eccentric anomaly')