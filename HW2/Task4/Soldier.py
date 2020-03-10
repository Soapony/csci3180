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

import random
from Pos import Pos

class Soldier():
    def __init__(self):
        self._health=100
        self.__num_elixirs=2
        self.__pos=Pos()
        self.__keys=[]
    
    def get_health(self):
        return self._health
    
    def lose_health(self):
        self._health -= 10
        return self._health <= 0
    
    def recover(self,healing_power):
        total_health = healing_power + self._health
        if(total_health >= 100):
            self._health=100
        else:
            self._health=total_health
    
    def get_pos(self):
        return self.__pos
    
    def set_pos(self,row,col):
        self.__pos.set_pos(row,col)
    
    def move(self,row,col):
        self.set_pos(row,col)
    
    def get_keys(self):
        return self.__keys

    def add_key(self,key):
        self.__keys.append(key)
    
    def get_num_elixirs(self):
        return self.__num_elixirs
    
    def add_elixir(self):
        self.__num_elixirs += 1
    
    def use_elixir(self):
        self.recover(random.randint(0,5)+15)
        self.__num_elixirs -= 1
    
    def display_information(self):
        str_key=[str(x) for x in self.__keys]
        print("Health: ",self._health,".")
        print("Position (row, column): (",self.__pos.get_row(),", ",self.__pos.get_col(),").")
        print("Keys: [" + ", ".join(str_key) + "].")
        print("Elixirs: ",self.__num_elixirs,".")
    
    def display_symbol(self):
        print("S",end="")
    
    