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
    """defines variables and plots graphs"""
    pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)
    pops
    infodict.keys()
    f1 = p.figure()
    p.plot(t, pops[:,0], 'g-', label='Resource density')
    p.plot(t,pops[:,1],'b-',label='Consumer density')
    p.grid()
    p.legend(loc='best')
    p.xlabel('Time')
    p.ylabel('Population density')
    p.title('Consumer resource population dynamics')
    #p.show()
    f1.savefig('../Results/LV_model_1.pdf')
    f2 = p.figure()
    p.plot(pops[:,0],pops[:,1] ,'r-')
    p.grid()
    #p.legend(loc='best')
    p.xlabel('Resource density')
    p.ylabel('Consumer density')
    p.title('Consumer resource population dynamics')
    #p.show()
    f2.savefig('../Results/LV_model_2.pdf')

# if (__name__ == "__main__"):
#     """runs main"""
#     status=main(sys.argv)
#     sys.exit(status)

    #poss moveing variables down????????