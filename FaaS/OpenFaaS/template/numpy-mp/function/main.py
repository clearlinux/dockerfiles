import sys
import os
import handler

def print_info():
    num = os.getenv('OMP_NUM_THREADS', 'calculated dynamically')
    return "OMP_NUM_THREADS is " + num


if __name__ == "__main__":
    st = print_info()
    ret = handler.handle(st)
    if ret != None:
        print(ret)
