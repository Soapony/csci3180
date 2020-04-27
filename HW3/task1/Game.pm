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

package Game;
use MannerDeckStudent; 
use Player;

sub new {
	my $class = shift @_;
    my @players = ();
    my @cards = ();
    my $self = {
        _deck => new MannerDeckStudent,
        _players => \@players,
        _cards => \@cards,
    };
    my $object = bless $self, $class;
    return $object;
}

sub set_players {
    my ($self,$ref) = @_;
    my @name_arr = @$ref;
    for my $i (0..$#name_arr){
        push(@{$self->{_players}},new Player($name_arr[$i]));
    }
    return 1;
}

sub getReturn {
    my($self) = @_;
    my @cards=@{$self->{_cards}};
    my $max=$#cards;
    my $target=$cards[$max];
    my $count=2;
    $max -=1;
    while($target ne $cards[$max])
    {
        $count += 1;
        $max -= 1;
    }
    return $count;
}

sub showCards {
    my($self) = @_;
	my @cards=@{$self->{_cards}};
    my $max= $#cards;
    for my $i (0..$max)
    {
        print("$cards[$i]");
        if($i != $max){
            print(" ");
        }
    }
    print("\n");
}

sub start_game {
    my($self) = @_;
    my $ps_ref = $self->{_players};
    my @ps = @$ps_ref;
    my $num_of_players = scalar @ps;
    if($num_of_players > 52)
    {
        print("Error: players number can not be over 52!\n");
        return 1;
    }
    if( (52 % $num_of_players) != 0)
    {
        print("Error: cards' number 52 can not be divided by players number $num_of_players!\n");
        return 1;
    }
    print("There ",$num_of_players," players in the game:\n");
    for my $i (0..$#ps)
    {
        print($ps[$i]->{_name}," ");
    }
    print("\n\nGame begin!!!\n\n");
    $self->{_deck}->shuffle();
    my @shuffled_cards=$self->{_deck}->AveDealCards($num_of_players);
    # put the cards into players deck
    for my $i (0..$#shuffled_cards)
    {
        for my $j (@{$shuffled_cards[$i]})
        {
            #print($j," ");
            $ps[$i]->getCards($j);
        }
        #print(@{$ps[$i]->{_cards}});
        #print("\n");
        #print($ps[$i]->numCards(),"\n");
    }
    my $flag = 1;
    my $turn = 0;
    my $round =1;
    while($flag)
    {
        print("Player ",$ps[$turn]->{_name}," has ",$ps[$turn]->numCards()," cards before deal.\n");
        print("=====Before player's deal=======\n");
        $self->showCards();
        print("================================\n");
        my $d_card = $ps[$turn]->dealCards();
        my $return_count=0;
        my $card_num=scalar @{$self->{_cards}};
        print($ps[$turn]->{_name}," ==> card $d_card\n");
        if($card_num == 0)
        {
            push(@{$self->{_cards}},$d_card);
        }
        elsif($d_card eq "J")
        {
            push(@{$self->{_cards}},$d_card);
            $return_count= scalar @{$self->{_cards}};
        }
        else
        {
            my $return_flag=0;
            for my $i (@{$self->{_cards}})
            {
                if($i eq $d_card)
                {
                    $return_flag=1;
                }
            }
            push(@{$self->{_cards}},$d_card);
            if($return_flag == 1)
            {
                $return_count= $self->getReturn();
            }
        }

        if($return_count != 0)
        {
            for (1..$return_count)
            {
                my $temp = pop(@{$self->{_cards}});
                $ps[$turn]->getCards($temp);
            }
        }
        print("=====After player's deal=======\n");
        $self->showCards();
        print("================================\n");
        print("Player ",$ps[$turn]->{_name}," has ",$ps[$turn]->numCards()," cards after deal.\n");
        #check num of cards
        if($ps[$turn]->numCards() == 0)
        {
            print("Player ",$ps[$turn]->{_name}," has no cards, out!\n");
            if($turn != $#ps)
            {
                for my $link ($turn..($#ps-1))
                {
                    $ps[$link]=$ps[$link+1];
                }
            }
            pop(@ps);
            $num_of_players -= 1;
            $turn -= 1;
        }
        print("\n");
        #chnge turn player
        $turn += 1;
        if($turn > ($num_of_players-1))
        {
            $turn = 0;
            $round +=1;
        }
        #check end game
        if($num_of_players == 1)
        {
            $flag=0;
        }
    }
    print("Winner is ",$ps[$turn]->{_name}," in game ",$round,"\n");

}

return 1;
