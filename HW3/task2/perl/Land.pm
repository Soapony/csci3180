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
package Land;

sub new {
    my $class = shift;
    my $self  = {
        owner => undef,
        level => 0,
    };
    bless $self, $class;
    return $self;
}

sub print {
    my $self = shift;
    if (!defined($self->{owner})) {
        print("Land ");
    } else {
        print("$self->{owner}->{name}:Lv$self->{level}");
    }
}

sub buyLand {

    # ...
    my $self = shift;
    if($main::cur_player->{money} >= 1100)
    {
        local $Player::due=1000;
        local $Player::handling_fee_rate=0.1;
        $main::cur_player->payDue();
        $self->{owner}=$main::cur_player;
        $self->{level}=0;
    }
    else
    {
        print("You do not have enough money to buy the land!\n");
    }
}

sub upgradeLand {

    # ... 
    my $self =shift;
    if($self->{level} == 0 && $main::cur_player->{money} >= 1100)
    {
        local $Player::due=1000;
        local $Player::handling_fee_rate=0.1;
        $main::cur_player->payDue();
        $self->{level} =1;
    }
    elsif($self->{level} == 1 && $main::cur_player->{money} >= 2200)
    {
        local $Player::due=2000;
        local $Player::handling_fee_rate=0.1;
        $main::cur_player->payDue();
        $self->{level} = 2;
    }
    elsif($self->{level} == 2 && $main::cur_player->{money} >= 5500)
    {
        local $Player::due=5000;
        local $Player::handling_fee_rate=0.1;
        $main::cur_player->payDue();
        $self->{level} =3;
    }
    else
    {
        print("You do not have enough money to upgrade the land!\n");
    }
}

sub chargeToll {

    # ...
    my $self = shift;
    my $due;
    my $tax_rate;
    if($self->{level} == 0)
    {
        $due=500;
        $tax_rate=0.1;
    }
    elsif($self->{level}==1)
    {
        $due=1000;
        $tax_rate=0.15;
    }
    elsif($self->{level}==2)
    {
        $due=1500;
        $tax_rate=0.2;
    }
    else
    {
        $due=3000;
        $tax_rate=0.25;
    }
    print("You need to pay player ",$self->{owner}->{name}," \$$due\n");
    if($main::cur_player->{money} < $due)
    {
        $due=$main::cur_player->{money};
    }
    local $Player::due=$due;
    local $Player::tax_rate=$tax_rate;
    $main::cur_player->payDue();
    # ...
    local $Player::income=$due;
    $Player::due=0;
    $self->{owner}->payDue();
}

sub stepOn {

    # ...
    my $self = shift;
    if(!defined($self->{owner}))
    {
        my $false=1;
        my $input;
        while($false)
        {
            print("Pay \$1000 to buy the land? [y/n]\n");
            chomp($input=<STDIN>);
            if($input eq "y" || $input eq "n")
            {
                $false = 0;
            }
        }
        if($input eq "y")
        {
            $self->buyLand();
        }
    }
    elsif($self->{owner}->{name} eq $main::cur_player->{name})
    {
        if($self->{level} != 3)
        {
            my $fee=0;
            if($self->{level} == 0)
            {
                $fee=1000;
            }
            elsif($self->{level} == 1)
            {
                $fee=2000;
            }
            elsif($self->{level} == 2)
            {
                $fee=5000;
            }
            my $false=1;
            my $input;
            while($false)
            {
                print("Pay \$$fee to upgrade the land? [y/n]\n");
                chomp($input=<STDIN>);
                if($input eq "y" || $input eq "n")
                {
                    $false = 0;
                }
            }
            if($input eq "y")
            {
                $self->upgradeLand();
            }
        }
    }
    else
    {
        $self->chargeToll();
    }

}
1;