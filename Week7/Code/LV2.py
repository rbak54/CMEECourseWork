#/usr/bin/env python3
"""Lotka volterra model incorporating density dependence with plotting"""
#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: Lv2.py
#Desc:Lotka volterra model with plotting
#Arguments: none
#Input: none 
#Output: none
#Date: Nov 2019
#import packages


#FUNCTIONS
def main(argv):
    """makes graphs"""
    import scipy as sc
    import scipy.stats as scs
    import sys
    import scipy.integrate as integrate
    import matplotlib.pylab as p
    import matplotlib.patches as mpatches

    def dCR_dt(pops, t=0):
        """returns growth rate of consumer and resource population at given time"""
        R = pops[0]
        C = pops[1]
        den = 1 - ( R / K )
        dRdt = r * R * den - a * R * C   
        dCdt = -z * C + e * a * R * C
        return sc.array([dRdt, dCdt])


    if len(argv) ==5: 
        r=float(argv[1])
        a=float(argv[2])
        z=float(argv[3])
        e=float(argv[4])
    else:
        r=1.
        a=0.1
        z=1.5
        e=0.75
        print("default values were used")

    t=sc.linspace(0,15,1000)
    R0=10
    C0=5
    RC0=sc.array([R0,C0])
    K=33

    pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)
    #pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)

    print("final resource density is")
    print(pops[-1][0])
    print("final consumer density is")
    print(pops[-1][1])

    f1 = p.figure()
    p.plot(t, pops[:,0], 'g-', label='Resource density')
    p.plot(t,pops[:,1],'b-',label='Consumer density')
    p.grid()
    rw="r="+str(r)
    aw="a="+str(a)
    zw="z="+str(z)
    ew="e="+str(e)
    kw="K="+str(K)
    rl = mpatches.Patch(color='none',label=rw)
    al = mpatches.Patch(color='none',label=aw)
    zl = mpatches.Patch(color='none',label=zw)
    el = mpatches.Patch(color='none',label=ew)
    kl = mpatches.Patch(color='none',label=kw)

    rd = mpatches.Patch(color='green',label="Resource Density")
    cd = mpatches.Patch(color='blue',label="Consumer Density")
    p.legend(handles=[rl,al,zl,el,kl,rd,cd],loc='best')
    p.xlabel('Time')
    p.ylabel('Population density')
    p.title('Consumer resource population dynamics')
    f1.savefig('../Results/LV_model_density_dependent_1.pdf')
    f2 = p.figure()
    p.plot(pops[:,0],pops[:,1] ,'r-')
    p.grid()
    #p.legend(loc='best')
    p.xlabel('Resource density')
    p.ylabel('Consumer density')
    p.title('Consumer resource population dynamics')
    p.legend(handles=[rl,al,zl,el,kl])
    f2.savefig('../Results/LV_model_density_dependent_2.pdf')
    
if __name__ == "__main__":
    """runs main"""
    import sys
    main(sys.argv)


