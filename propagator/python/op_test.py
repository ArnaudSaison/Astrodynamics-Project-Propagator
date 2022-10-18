import numpy as np
import matplotlib.pyplot as plt
from math import sqrt
plt.style.use('dark_background')

import Planetary_data as pd
from Orbit_Propagation import OrbitPropagator as OP, null_perts
import tools as t


cb = pd.earth

# time parameters
tspan = 10*24*3600
dt = 100

if __name__ == '__main__':
    # a,e,i,ta,aop,raan=coes
    
    # ISS
    c0=[cb['radius']+414.0,0.0003447,51.6427,0.0,313.4987,90.5895]
    # GEO
    c1 = [cb['radius']+35800.0,0.0,0.0,0.0,0.0,0.0]
    
    # Perturbation
    perts = null_perts()
    perts['J2']=True

    op0 = OP(c0,tspan,dt,coes=True,cb=cb,perts=perts)
    op00 = OP(c1,tspan,dt,coes=True,cb=cb,perts=perts)
    
    op0.propagate_orbit()
    op00.propagate_orbit()
    
    t.plot_n_orbits([op0.rs,op00.rs],labels=['ISS','GEO'],cb=cb,show_plot = True)





'''
if __name__ == '__main__':
    # initial condition of orbit parameters
    r_mag = cb['radius'] + 1500       # km
    v_mag = sqrt(cb['mu']/r_mag)     # km/s
    
    # initial position and velocity vector
    r0 = np.array([r_mag,0,0])
    v0 = np.array([0,v_mag,0])
    
    # initial condition of orbit parameters
    r_mag = cb['radius'] + 2000       # km
    v_mag = sqrt(cb['mu']/r_mag)     # km/s
    
    # initial position and velocity vector
    r00 = np.array([r_mag,0,0])
    v00 = np.array([0,2*sqrt(v_mag),2*sqrt(v_mag)])
    
    # Perturbation
    perts = null_perts()
    perts['J2']=True
    
    op0 = OP(r0,v0,tspan,dt,cb=cb,perts=perts)
    op00 = OP(r00,v00,tspan,dt,cb=cb,perts=perts)
    
    op0.propagate_orbit()
    op00.propagate_orbit()
    
    t.plot_n_orbits([op0.rs,op00.rs],labels=['0','1'],cb=cb,show_plot = True)
    '''