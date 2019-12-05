#/usr/bin/env python3
"""Lotka volterra model with plotting"""

#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: Lv1.py
#Desc: Lotka volterra model with plotting
#Arguments: none
#Input: none 
#Output: none
#Date: Nov 2019
#import packages
import scipy as sc
import scipy.stats
import scipy.integrate as integrate
import matplotlib.pylab as p
import sys

#define paramaters for dCR_dt
r=1
a=0.1
z=1.5
e=0.75
t=sc.linspace(0,15,1000)
R0=10
C0=5
RC0=sc.array([R0,C0])

def dCR_dt(pops, t=0):
    """returns growth rate of consumer and resource population at given time"""
    R = pops[0]
    C = pops[1]
    dRdt = r * R - a * R * C
    dCdt = -z * C + e * a * R * C
    return sc.array([dRdt, dCdt])

def main():
    """plots graphs"""
    #integrates equation
    pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)
    #makes figure1
    f1 = p.figure()
    p.plot(t, pops[:,0], 'g-', label='Resource density')
    p.plot(t,pops[:,1],'b-',label='Consumer density')
    p.legend(loc='best')
    p.grid()
    p.xlabel('Time')
    p.ylabel('Population density')
    p.title('Consumer-resource population dynamics')
    f1.savefig('../Results/LV_model_1.pdf')

    #makes figure 2
    f2 = p.figure()
    p.plot(pops[:,0],pops[:,1] ,'r-')
    p.grid()
    p.xlabel('Resource density')
    p.ylabel('Consumer density')
    p.title('Consumer-resource population dynamics')
    f2.savefig('../Results/LV_model_2.pdf')
    p.close('all')
    #prints final densities
    print("final resource density is:")
    print(pops[-1][0])
    print("final consumer density is:")
    print(pops[-1][1])
    print("figures saved in Results")
if (__name__ == "__main__"):
    """runs main"""
    main()
