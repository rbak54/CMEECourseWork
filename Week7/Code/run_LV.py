#Author: Ruth Keane (ruth.keane19@imperial.ac.uk)
#Script: LV3.py
#Desc: runs and profiles LV1.py and LV2.py
#Arguments: none
#Input: none 
#Output: none
#Date: Not 2019
# """runs and profiles LV1.py and LV2.py"""
# __appname__='[LV_3]'
# __author__='Ruth Keane (ruth.keane19@imperial.ac.uk)'
# __version__='0.0.1'
# __license__='Public domain'
import time
import LV1
LV1.main()
#from LV1 import main()
import LV2
LV2.main(r=1., a=0.1, z=1.5, e=0.75)
#runs without about if used hashed out versions of LV2
import cProfile
import timeit
cProfile.run('LV1.main()')
def var():
    r=1
    a=1
    z=1
    e=1
    return(r,a,z,e)
#cProfile.run('LV2.main(r=1., a=0.1, z=1.5, e=0.75)')
#%timeit LV2(r,a,z,e)
# use os ???
%run -p LV1.py
%run -p LV2
#%run -p [prof_opts] filename.py [args to program]
#LV1.main()
# import LV2.py
# >>> def wrapper(func, *args, **kwargs):
# ...     def wrapped():
# ...         return func(*args, **kwargs)
# ...     return wrapped
# ...
# >>> def costly_func(lst): 
# ...     return map(lambda x: x^2, lst) 
# ... 
# >>> short_list = range(10) 
# >>> wrapped = wrapper(costly_func, short_list)
# >>> timeit.timeit(wrapped, number=1000)
# 0.0032510757446289062
# >>> long_list = range(1000)
# >>> wrapped = wrapper(costly_func, long_list)
# >>> timeit.timeit(wrapped, number=1000)
# 0.14835596084594727
# if (__name__ == "__main__"):
#     """runs main"""
#     status=main(sys.argv)
#     sys.exit(status)
	
# # mymodule.py
# def costly_func():
#     return map(lambda x: x^2, range(1000))

	
# >>> timeit.timeit('costly_func()', setup='from mymodule import costly_func', number=1000)
# 0.15768003463745117
# # OR just import it in the local namespace
# >>> 
# >>> timeit.timeit(costly_func, number=1000)
# 0.1535871028900146