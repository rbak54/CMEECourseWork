#!/usr/bin/env python3
"""Description of this programme or application. 
    You can use several lines"""
__appname__='simple boilerplate'
__author__='Ruth Keane (ruth.keane19@imperial.ac.uk)'
__version__='0.0.1'
__license__="License for this code/programme"

## imports##
import sys #module to interface our program with the operating system
##constants##

##functions##
def main(argv):
    """Main entry point of the program"""
    print('This is a boilerplate') # Note: indented using 2 tabs or 4 space
    return 0

if __name__=="__main__":
    """Makes sure the "main" function is called from command line"""
    status = main(sys.argv)
    sys.exit(status)