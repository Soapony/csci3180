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
class Task4Soldier extends Soldier{
    private int coin;
    private int shield;

    public Task4Soldier(){
        super();
        this.coin=0;
        this.shield=0;
    }

    public void addCoin(){
        this.coin+=1;
    }
    public void loseCoin(int price){
        this.coin-=price;
    }

    public int getCoin(){
        return this.coin;
    }

    public void addShield(){
        this.shield+=5;
    }

    public int getShield(){
        return this.shield;
    }

    public boolean loseHealth(){
        int damage=10-this.shield;
        if (damage<0){
            damage=0;
        }
        super.health -= damage;
        return super.health <= 0;
    }

    public void displayInformation(){
        super.displayInformation();
        System.out.printf("Defence: %d.%n",this.shield);
        System.out.printf("Coins: %d.%n",this.coin);
    }
}