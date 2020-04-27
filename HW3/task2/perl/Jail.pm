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
use strict;
use warnings;
require "./Player.pm";

package Jail;
sub new {
    my $class = shift;
    my $self  = {};
    bless $self, $class;
    return $self;
}

sub print {
    print("Jail ");
}

sub stepOn {

    # ...
    my $false=1;
    my $input;
    while($false)
    {
        print("Pay \$1000 to reduce the prison round to 1? [y/n]\n");
        chomp($input=<STDIN>);
        if($input eq "y" || $input eq "n")
        {
            $false = 0;
        }
    }
    if($input eq "y")
    {
        if($main::cur_player->{money} >= 1100)
        {
            local $Player::due=1000;
            local $Player::handling_fee_rate=0.1;
            $main::cur_player->payDue();
            local $Player::prison_rounds=1;
            $main::cur_player->putToJail();
        }
        else
        {
            print("You do not have enough money to reduce the prison round!\n");
            $main::cur_player->putToJail();
        }
    }
    else
    {
        $main::cur_player->putToJail();
    }
}

1;
