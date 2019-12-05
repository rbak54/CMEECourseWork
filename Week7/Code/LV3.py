#/usr/bin/env python3
"""Lotka volterra model discrete"""
#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: LV3.py
#Desc: Lotka volterra model discrete
#Arguments: none
#Input: none 
#Output: none
#Date: Nov 2019

def main():
    """runs and plots discrete model"""
    #import packages
    import scipy as sc
    import scipy.stats as scs
    import sys
    import scipy.integrate as integrate
    import matplotlib.pylab as p
    import matplotlib.patches as mpatches

    #define variables
    R0=10.
    #10 resources per unit are initially
    C0=5. 
    #5 consumers per unit area initially
    r=1.
    a=0.1
    z=1.5
    e=0.75
    Rt=sc.zeros(16)
    Rt[0]=R0
    Ct=sc.zeros(16)
    Ct[0]=C0
    K=33.
    #for each timepoint, change Rt and Ct (only if positive)
    for i in (range(15)):
        if Rt[i]>0:
            Rt[i+1] = Rt[i]*(1+r*(1-(Rt[i]/K))-a*Ct[i])
        else:
            Rt[i+1]=0
        if Ct[i]>0:
            Ct[i+1]= Ct[i]*(1-z+e*a*Rt[i])
        else:
            Ct[i+1]=0
    print("Final resource density is:")
    print(Rt[-1])
    print("Final consumer density is:")
    print(Ct[-1])
    
    #figure 1
    f1 = p.figure()
    tlen=len(Rt)
    t=range(tlen)
    p.plot(t, Rt, 'g-', label='Resource density')
    p.plot(t,Ct,'b-',label='Consumer density')
    p.grid()
    rl = mpatches.Patch(color='none',label=("r="+str(r)))
    al = mpatches.Patch(color='none',label=("a="+str(a)))
    zl = mpatches.Patch(color='none',label=("z="+str(z)))
    el = mpatches.Patch(color='none',label=("e="+str(e)))
    kl = mpatches.Patch(color='none',label=("K="+str(K)))
    rd = mpatches.Patch(color='green',label="Resource Density")
    cd = mpatches.Patch(color='blue',label="Consumer Density")
    p.legend(handles=[rl,al,zl,el,kl,rd,cd],loc='best')
    p.xlabel('Time')
    p.ylabel('Population density')
    p.title('Consumer resource population dynamics')
    
    #figure 2 
    f1.savefig('../Results/LV_model_1_discrete.pdf')
    f2 = p.figure()
    p.plot(Rt,Ct,'r-')
    p.grid()
    p.xlabel('Resource density')
    p.ylabel('Consumer density')
    p.title('Consumer resource population dynamics')
    p.legend(handles=[rl,al,zl,el,kl],loc='best')
    f2.savefig('../Results/LV_model_2_discrete.pdf')
    p.close('all')
    print("figures saved in Results")

if __name__ == "__main__":
    """runs main"""
    main()