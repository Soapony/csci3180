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
from Cell import Cell
from Map import Map
from Task4Monster import Task4Monster
from Task4Soldier import Task4Soldier
from Spring import Spring
from Task4Merchant import Task4Merchant

class task4_save_the_tribe():
    def __init__(self):
        self.__map=Map()
        self.__soldier=Task4Soldier()
        self.__spring=Spring()
        self.__monsters=[]
        self.__merchant=Task4Merchant()
        self.__game_enabled=True

    def initialize(self):
        self.__monsters.append(Task4Monster(1,random.randint(0,4)*10+30))
        self.__monsters[0].set_pos(4,1)
        self.__monsters[0].add_drop_item(2)
        self.__monsters[0].add_drop_item(3)

        self.__monsters.append(Task4Monster(2,random.randint(0,4)*10+30))
        self.__monsters[1].set_pos(3,3)
        self.__monsters[1].add_drop_item(3)
        self.__monsters[1].add_drop_item(6)
        self.__monsters[1].add_hint(1)
        self.__monsters[1].add_hint(2)

        self.__monsters.append(Task4Monster(3,random.randint(0,4)*10+30))
        self.__monsters[2].set_pos(5,3)
        self.__monsters[2].add_drop_item(4)
        self.__monsters[2].add_hint(1)
        self.__monsters[2].add_hint(2)

        self.__monsters.append(Task4Monster(4,random.randint(0,4)*10+30))
        self.__monsters[3].set_pos(5,5)
        self.__monsters[3].add_hint(3)
        self.__monsters[3].add_hint(6)

        self.__monsters.append(Task4Monster(5,random.randint(0,4)*10+30))
        self.__monsters[4].set_pos(1,4)
        self.__monsters[4].add_drop_item(2)
        self.__monsters[4].add_drop_item(6)

        self.__monsters.append(Task4Monster(6,random.randint(0,4)*10+30))
        self.__monsters[5].set_pos(3,5)
        self.__monsters[5].add_drop_item(4)
        self.__monsters[5].add_drop_item(7)
        self.__monsters[5].add_hint(2)
        self.__monsters[5].add_hint(5)

        self.__monsters.append(Task4Monster(7,random.randint(0,4)*10+30))
        self.__monsters[6].set_pos(4,7)
        self.__monsters[6].add_drop_item(-1)
        self.__monsters[6].add_hint(6)

        self.__map.add_object(self.__monsters)

        self.__soldier.set_pos(1,1)
        self.__soldier.add_key(1)
        self.__soldier.add_key(5)

        self.__map.add_object(self.__soldier)

        self.__spring.set_pos(7,4)

        self.__map.add_object(self.__spring)

        self.__merchant.set_pos(7,7)

        self.__map.add_object(self.__merchant)
    
    def start(self):
        print("=> Welcome to the desert!")
        print("=> Now you have to defeat the monsters and find the artifact to save the tribe.\n\n")
        while(self.__game_enabled):
            self.__map.display_map()
            self.__soldier.display_information()

            move=input("\n=> What is the next step? (W = Up, S = Down, A = Left, D = Right.) Input: ")
            
            pos=self.__soldier.get_pos()
            new_row=old_row=pos.get_row()
            new_col=old_col=pos.get_col()

            if((move == 'w') or (move == 'W')):
                new_row = old_row -1
            elif((move == 's') or (move == 'S')):
                new_row = old_row +1
            elif((move == 'a') or (move == 'A')):
                new_col = old_col -1
            elif((move == 'd') or (move == 'D')):
                new_col = old_col +1
            else:
                print("=> Illegal move!\n\n")
                continue

            if(self.__map.check_move(new_row,new_col)):
                occupied_object=self.__map.get_occupied_object(new_row,new_col)

                if(type(occupied_object) is Task4Monster):
                    occupied_object.action_on_soldier(self.__soldier)
                elif(type(occupied_object) is Spring):
                    occupied_object.action_on_soldier(self.__soldier)
                elif(type(occupied_object) is Task4Merchant):
                    occupied_object.action_on_soldier(self.__soldier)
                else:
                    self.__soldier.move(new_row,new_col)
                    self.__map.update(self.__soldier, old_row, old_col, new_row, new_col)
                    print(end="\n\n")
            else:
                print("=> Illegal move!\n\n")
            
            if(self.__soldier.get_health() <= 0):
                print("\n=> You died.\n")
                print("=> Game over.\n\n")
                self.__game_enabled=False
            
            if(self.__soldier.get_keys().count(-1)):
                print("=> You found the artifact.")
                print("=> Game over.\n\n")
                self.__game_enabled=False

if __name__ == '__main__':
    game=task4_save_the_tribe()
    game.initialize()
    game.start()
