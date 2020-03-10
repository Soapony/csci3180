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
from Soldier import Soldier

class Task4Soldier(Soldier):
    def __init__(self):
        super().__init__()
        self.__coin=0
        self.__shield=0
    
    def add_coin(self):
        self.__coin += 1
    
    def lose_coin(self,price):
        self.__coin -= price
    
    def get_coin(self):
        return self.__coin
    
    def add_shield(self):
        self.__shield += 5
    
    def get_shield(self):
        return self.__shield
    
    def lose_health(self):
        damage= 10 - self.__shield
        if (damage < 0):
            damage=0
        self._health -= damage
        return self._health <= 0

    def display_information(self):
        super().display_information()
        print("Defence: %d."%self.__shield)
        print("Coins: %d."%self.__coin)
    