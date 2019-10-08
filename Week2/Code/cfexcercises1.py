def foo_1(x):
    return x ** 0.5
#finds the square root of x
def foo_2(x,y):
    if x>y:
        return x
    return y 
#returns largest one
def foo_3(x,y,z):
    if x>y:
        tmp=y
        y=x
        x=tmp
    if y>z:
        tmp=z
        z=y
        y=tmp
    return[x,y ,z]
#if not x>y>z then switches some around
def foo_4(x):
    result = 1
    for i in range(1, x+1):
        result=result*i
    return result
#for 1 until x+1 , multiply by 1, then multiply that by 1+1 etc
#so factorial!!
#WHY PLUS ONE?
def foo_5(x):
    if x==1:
        return 1
    return x* foo_5(x-1)
#factorial?? recursive apparently
def foo_6(x):
    facto=1
    while x>=1: 
        facto = facto * x
        x= x-1
    return facto
#factorial again, go over
