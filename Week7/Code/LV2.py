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
    #import packages
    import scipy as sc
    import scipy.stats as scs
    import sys
    import scipy.integrate as integrate
    import matplotlib.pylab as p
    import matplotlib.patches as mpatches

    #define dCR_dt
    def dCR_dt(pops, t=0):
        """returns growth rate of consumer and resource population at given time"""
        R = pops[0]
        C = pops[1]
        den = 1 - ( R / K )
        dRdt = r * R * den - a * R * C   
        dCdt = -z * C + e * a * R * C
        return sc.array([dRdt, dCdt])

    #if variables in command line, use those
    if len(argv) ==5: 
        r=float(argv[1])
        a=float(argv[2])
        z=float(argv[3])
        e=float(argv[4])
    #otherwise use default variables
    else:
        r=1.
        a=0.1
        z=1.5
        e=0.75
        print("default values were used")
    #define other variables
    t=sc.linspace(0,15,1000)
    R0=10
    C0=5
    RC0=sc.array([R0,C0])
    K=33
    #integrate
    pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)

    print("Final resource density is:")
    print(pops[-1][0])
    print("Final consumer density is:")
    print(pops[-1][1])
    #plot figure 1 
    f1 = p.figure()
    p.plot(t, pops[:,0], 'g-', label='Resource density')
    p.plot(t,pops[:,1],'b-',label='Consumer density')
    p.grid()

    #prepare labels to add to figure    
    rl = mpatches.Patch(color='none',label=("r="+str(r)))
    al = mpatches.Patch(color='none',label=("a="+str(a)))
    zl = mpatches.Patch(color='none',label=("z="+str(z)))
    el = mpatches.Patch(color='none',label=("e="+str(e)))
    kl = mpatches.Patch(color='none',label=("K="+str(K)))
    rd = mpatches.Patch(color='green',label="Resource Density")
    cd = mpatches.Patch(color='blue',label="Consumer Density")
    #add legend
    p.legend(handles=[rl,al,zl,el,kl,rd,cd],loc='best')
    p.xlabel('Time')
    p.ylabel('Population density')
    p.title('Consumer-resource population dynamics')
    f1.savefig('../Results/LV_model_density_dependent_1.pdf')
    #plot figure 2
    f2 = p.figure()
    p.plot(pops[:,0],pops[:,1] ,'r-')
    p.grid()
    p.xlabel('Resource density')
    p.ylabel('Consumer density')
    p.title('Consumer-resource population dynamics')
    p.legend(handles=[rl,al,zl,el,kl])
    f2.savefig('../Results/LV_model_density_dependent_2.pdf')
    p.close('all')
    print("figures saved in Results")

if __name__ == "__main__":
    """runs main"""
    import sys
    main(sys.argv)


