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

from Pos import Pos

class Task4Merchant():
    def __init__(self):
        self.__elixir_price = 1
        self.__shield_price = 2
        self.__pos = Pos()
    
    def action_on_soldier(self,soldier):
        sc=input("Do you want to buy something? (1. Elixir, 2. Shield, 3. Leave.) Input: ")
        if(sc == '1'):
            if(soldier.get_coin() >= self.__elixir_price):
                soldier.add_elixir()
                soldier.lose_coin(self.__elixir_price)
                self.talk("You bought an Elixir.\n\n")
            else:
                self.talk("You don't have enough coins.\n\n")
        elif(sc == '2'):
            if(soldier.get_coin() >= self.__shield_price):
                soldier.add_shield()
                soldier.lose_coin(self.__shield_price)
                self.talk("You bought a shield.\n\n")
            else:
                self.talk("You don't have enough coins.\n\n")
        elif(sc == '3'):
            self.talk("Thank you for coming. :D\n\n")
        else:
            print("=> Illegal choice!\n\n")
    
    def talk(self,text):
        print("Merchant$",text,end='')
    
    def set_pos(self,row,col):
        self.__pos.set_pos(row,col)
    
    def get_pos(self):
        return self.__pos
    
    def display_symbol(self):
        print("$",end='')
