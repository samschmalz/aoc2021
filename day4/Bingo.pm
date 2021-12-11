package Bingo;
use strict;
use warnings;

use Data::Dumper;

use List::Util qw( sum );

use Exporter qw(import);

our @Export = qw( check_number check_win );

sub check_number {
	my($number, $bingo_card_ref, $score_card_ref) = @_;
	my (@bingo_card, @score_card) = (@$bingo_card_ref, @$score_card_ref);

	foreach my $i (0 .. 4) {
		my $break = 0;
		foreach my $j (0 .. 4) {
			if ($bingo_card[$i][$j] == $number) {
				$score_card[$i][$j] = 1;
				$break = 1;
				last;
			}
		}
		last if $break;
	}
	print Dumper @score_card;
	return \@score_card;
}

sub check_win {
	my $bingo_card_ref = shift;
	my @bingo_card = @$bingo_card_ref;

	my $win = 0;
	my @col_sums = ( 0,0,0,0,0 );

	foreach my $i (0 .. 4) {
		if (sum($bingo_card[$i]) == 5) {
			$win = 1;
			print("Winner!\n");
			last;
		}
		foreach my $j (0 .. 4) {
			$col_sums[$j] += $bingo_card[$i][$j];
		}
	}

	if ( 5 ~~ @col_sums ) {
		$win = 1;
		print("Winner!\n");
	}

	return $win;
}

1;