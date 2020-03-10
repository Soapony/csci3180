"""
∗ CSCI3180 Principles of Programming Languages ∗
∗ --- Declaration --- ∗
∗ I declare that the assignment here submitted is original except for source
∗ material explicitly acknowledged. I also acknowledge that I am aware of
∗ University policy and regulations on honesty in academic work, and of the
∗ disciplinary guidelines and procedures applicable to breaches of such policy
∗ and regulations, as contained in the website
∗ http://www.cuhk.edu.hk/policy/academichonesty/ ∗
∗ Assignment 2
∗ Name : Feng Haolin
∗ Student ID : 1155110663
∗ Email Addr : hlfeng8@cse.cuhk.edu.hk ∗/
"""

class Pos():
    def __init__(self):
        self.__col=-1
        self.__row=-1
    def set_pos(self,row,col):
        self.__col=col
        self.__row=row
    def get_row(self):
        return self.__row
    def get_col(self):
        return self.__col