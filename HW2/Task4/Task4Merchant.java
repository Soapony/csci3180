/*
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
*/
import java.util.Scanner;

public class Task4Merchant {
  private int elixirPrice;
  private int shieldPrice;
  private Pos pos;

  public Task4Merchant() {
      this.elixirPrice= 1;
      this.shieldPrice= 2;
      this.pos = new Pos();
  }

  public void actionOnSoldier(Task4Soldier soldier) {
    this.talk("Do you want to buy something? (1. Elixir, 2. Shield, 3. Leave.) Input: ");

    Scanner sc = new Scanner(System.in);
    String choice = sc.nextLine();
    if(choice.equalsIgnoreCase("1"))
    {
        if(soldier.getCoin() >= this.elixirPrice)
        {
            soldier.addElixir();
            soldier.loseCoin(this.elixirPrice);
            this.talk("You bought an Elixir.%n%n");
        }
        else
        {
            this.talk("You don't have enough coins.%n%n");
        }
    }
    else if(choice.equalsIgnoreCase("2"))
    {
        if(soldier.getCoin() >= this.shieldPrice)
        {
            soldier.addShield();
            soldier.loseCoin(this.shieldPrice);
            this.talk("You bought a shield.%n%n");
        }
        else
        {
            this.talk("You don't have enough coins.%n%n");
        }
    }
    else if(choice.equalsIgnoreCase("3"))
    {
        this.talk("Thank you for coming. :D%n%n");
    }
    else
    {
        System.out.printf("=> Illegal choice!%n%n");
    }
  }

  public void talk(String text) {
    System.out.printf("Merchant$: " + text);
  }

  public void setPos(int row, int column) {
    this.pos.setPos(row, column);
  }

  public Pos getPos() {
    return this.pos;
  }

  public void displaySymbol(){
      System.out.print("$");
  }
}