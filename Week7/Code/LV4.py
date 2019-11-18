#/usr/bin/env python3
"""Lotka volterra model discrete with variability"""
#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: LV4.py
#Desc: Lotka volterra model discrete with variability
#Arguments: none
#Input: none 
#Output: none
#Date: Nov 2019
##variability?? NEED TO ACTUALL ADD
def main():
    """runs and plots discrete model with variability"""
    import scipy as sc
    import scipy.stats as scs
    from scipy.stats import norm
    import sys
    import scipy.integrate as integrate
    import matplotlib.pylab as p
    import matplotlib.patches as mpatches

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
    for i in (range(15)):
        if Rt[i]>0:
            epsilon=norm.rvs()
            Rt[i+1] = Rt[i]*(1+(r+epsilon)*(1-(Rt[i]/K))-a*Ct[i])
        else:
            Rt[i+1]=0
        if Ct[i]>0:
            Ct[i+1]= Ct[i]*(1-z+e*a*Rt[i])
        else:
            Ct[i+1]=0
    for j in range(16):
        if Rt[j]<0:
            Rt[j]=0
        if Ct[j]<0:
            Ct[j]=0
    print("final resource density is")
    print(Rt[-1])
    print("final consumer density is")
    print(Ct[-1])
    f1 = p.figure()
    tlen=len(Rt)
    t=range(tlen)
    p.plot(t, Rt, 'g-', label='Resource density')
    p.plot(t,Ct,'b-',label='Consumer density')
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
    #p.show()
    f1.savefig('../Results/LV_model_1_discrete_fluctuatingresource.pdf')
    f2 = p.figure()
    p.plot(Rt,Ct,'r-')
    p.grid()
    #p.legend(loc='best')
    p.xlabel('Resource density')
    p.ylabel('Consumer density')
    p.title('Consumer resource population dynamics_fluctuatingresource.pdf')
    p.legend(handles=[rl,al,zl,el,kl],loc='best')
    #p.show()
    f2.savefig('../Results/LV_model_2_discrete.pdf')

if __name__ == "__main__":
    """runs main"""
    main()