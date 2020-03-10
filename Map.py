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
from Cell import Cell
from Pos import Pos

class Map():
    def __init__(self):
        self.__cells=[[None for col in range(7)]for row in range(7)]
        for i in range(len(self.__cells)):
            for j in range(len(self.__cells[0])):
                self.__cells[i][j]=Cell()
    def add_object(self,a_object):
        pos=Pos()
        if type(a_object) is list:
            for i in a_object:
                pos=i.get_pos()
                self.__cells[pos.get_row()-1][pos.get_col()-1].set_occupied_object(i)
        else:
            pos=a_object.get_pos()
            if pos is not None:
                self.__cells[pos.get_row()-1][pos.get_col()-1].set_occupied_object(a_object)
    def display_map(self):
        print("   | 1 | 2 | 3 | 4 | 5 | 6 | 7 |")
        print("--------------------------------")
        for i in range(7):
            print("",i+1,"|",end='')
            for j in range(7):
                occupied_object=self.__cells[i][j].get_occupied_object()
                if(occupied_object != 0):
                    print(" ",end='')
                    occupied_object.display_symbol()
                    print(" |",end='')
                else:
                    print("   |",end='')
            print("")
            print("--------------------------------")
        print("\n")
    def get_occupied_object(self,row,col):
        return self.__cells[row-1][col-1].get_occupied_object()
    
    def check_move(self,row,col):
        return ((row >= 1 and row <=7) and (col >= 1 and col <= 7))
    
    def update(self,soldier,old_row,old_col,new_row,new_col):
        self.__cells[old_row-1][old_col-1].set_occupied_object(0)
        self.__cells[new_row-1][new_col-1].set_occupied_object(soldier)
