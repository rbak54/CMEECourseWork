
#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: scope.py
#Desc:functions exploring local and global variables
#Arguments: none
#Input: none
#Output: none
#Date: Oct 2019
"""functions exploring local and global variables"""

#defining a function, in this function _a_global and _b_global are different but once the function is over global returns to original values
_a_global = 10

if _a_global >= 5:
    _b_global = _a_global + 5

def a_function():
    _a_global = 5

    if _a_global >= 5:
        _b_global = _a_global +5

    _a_local =4

    print ("Inside the function, th value of _a_global is",_a_global)
    print ("Inside the function, the value of _b_global is", _b_global)
    print ("Inside the function, the value of _a_local is", _a_local)

    return None

a_function()
print("Outside the function, the value of _a_global is",_a_global)
print("Outside the function, the value of _b_global is", _b_global)

#in a function, global variables are still available
_a_global = 10
def a_function():
    _a_local = 4 

    print("Inside the function, the value of _a_local is", _a_local)
    print("Inside the function, the value of _a_global is", _a_global)

    return None

a_function()

print("Outside the function, the value of _a_global is", _a_global)


#value of _a_global changes because it has been categorised as a global function
_a_global = 10
print ("Outside the function, the value of _a_global is" ,_a_global)

def a_function():
    global _a_global
    _a_global = 5
    _a_local = 4
    
    print("Inside the function, the value of _a_global is", _a_global)
    print("Inside the function, the value of _a_local is", _a_local)

    return None

a_function()

print("Outside the function, the value of _a_global now is", _a_global)


###value of a_global changes when global is used in a function 
def a_function():
    _a_global = 10

    def _a_function2():
        global _a_global
        _a_global =20

    print("Before calling a_function, value of _a_global is", _a_global)

    _a_function2()

    print("After calling _a_function2, value of _a_global is", _a_global)

    return None

a_function()

print("The value of a_global in main workspace/namespace is", _a_global)
 
####_a_global is 10, then when function is called becomes 20. because global is used, it becomes 20 in the workspace
_a_global = 10

def a_function(): 
    def _a_function2():
        global _a_global
        _a_global = 20

    print("Before calling a function, value of _a_global is", _a_global)

    _a_function2()

    print("After calling _a_function2, value of _a_global is " ,_a_global)

a_function()

print("The value of a_global in main workspace / namespace is", _a_global)
