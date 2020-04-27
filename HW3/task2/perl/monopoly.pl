=pod
/∗
∗ CSCI3180 Principles of Programming Languages
*
∗ --- Declaration --- ∗
∗ I declare that the assignment here submitted is original except for source
∗ material explicitly acknowledged. I also acknowledge that I am aware of
∗ University policy and regulations on honesty in academic work, and of the
∗ disciplinary guidelines and procedures applicable to breaches of such policy
∗ and regulations, as contained in the website
∗ http://www.cuhk.edu.hk/policy/academichonesty/ ∗
∗ Assignment 3
∗ Name : Feng Haolin
∗ Student ID : 1155110663
∗ Email Addr : hlfeng8@cse.cuhk.edu.hk 
∗/
=cut
#! /usr/bin/perl
use warnings;
use strict;
require "./Bank.pm";
require "./Jail.pm";
require "./Land.pm";
require "./Player.pm";

our @game_board = (
    new Bank(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Jail(),
    new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(),
    new Jail(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Jail(),
    new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(),
);
our $game_board_size = @game_board;

our @players = (new Player("A"), new Player("B"));
our $num_players = @players;

our $cur_player_idx = 0;
our $cur_player = $players[$cur_player_idx];
our $cur_round = 0;
our $num_dices = 1;

srand(0); # don't touch

# game board printing utility. Used to show player position.
sub printCellPrefix {
    my $position = shift;
    my @occupying = ();
    foreach my $player (@players) {
        if ($player->{position} == $position && $player->{money} > 0) {
            push(@occupying, ($player->{name}));
        }
    }
    print(" " x ($num_players - scalar @occupying), @occupying);
    if (scalar @occupying) {
        print("|");
    } else {
        print(" ");
    }
}

sub printGameBoard {
    print("-"x (10 * ($num_players + 6)), "\n");
    for (my $i = 0; $i < 10; $i += 1) {
        printCellPrefix($i);
        $game_board[$i]->print();
    }
    print("\n\n");
    for (my $i = 0; $i < 8; $i += 1) {
        printCellPrefix($game_board_size - $i - 1);
        $game_board[-$i-1]->print();
        print(" "x (8 * ($num_players + 6)));
        printCellPrefix($i + 10);
        $game_board[$i+10]->print();
        print("\n\n");
    }
    for (my $i = 0; $i < 10; $i += 1) {
        printCellPrefix(27 - $i);
        $game_board[27-$i]->print();
    }
    print("\n");
    print("-"x (10 * ($num_players + 6)), "\n");
}

sub terminationCheck {

    # ...
    foreach my $player (@players)
    {
        if($player->{money} <=0)
        {
            return 0;
        }
    }
    return 1;
}

sub throwDice {
    my $step = 0;
    for (my $i = 0; $i < $num_dices; $i += 1) {
        $step += 1 + int(rand(6));
    }
    return $step;
}

sub main {
    while (terminationCheck()){
        $cur_player_idx= $cur_round % 2;
        $cur_player=$players[$cur_player_idx];
        if($cur_player->{num_rounds_in_jail})
        {
            $cur_player->{num_rounds_in_jail} -= 1;
            $cur_player->payDue();
            $cur_round += 1;
            next;
        }
        printGameBoard();
        foreach my $player (@players) {
            $player->printAsset();
        }

        # ...
        $cur_player->payDue();
        if($cur_player->{money} <=0)
        {
            $cur_player->{money} = 0;
        }
        print("Player $cur_player->{name}'s turn.\n");
        my $false=1;
        my $choose;
        while($false)
        {
            print("Pay \$500 to throw two dice? [y/n]\n");
            chomp($choose=<STDIN>);
            if($choose eq "y" || $choose eq "n")
            {
                $false=0;
            }
        }
        my $steps;
        if($choose eq "y")
        {
            if($cur_player->{money} >=525)
            {
                local $num_dices=2;
                local $Player::due=500;
                local $Player::handling_fee_rate=0.05;
                $cur_player->payDue();
                $steps=throwDice();
            }
            else
            {
                print("You do not have enough money to throw two dice!\n");
                $steps=throwDice();
            }
        }
        else
        {
            $steps=throwDice();
        }
        if($cur_player->{money} <=0)
        {
            $cur_player->{money} = 0;
        }
        print("Points of dice: $steps\n");
        $cur_player->move($steps);
        printGameBoard();
        $game_board[$cur_player->{position}]->stepOn();
        if($cur_player->{money} <=0)
        {
            $cur_player->{money} = 0;
        }

        $cur_round += 1;
    }
    foreach my $player (@players)
    {
        if($player->{money} > 0)
        {
            print("Game over! winner: $player->{name}.\n");
            return;
        }
    }

}

main();
