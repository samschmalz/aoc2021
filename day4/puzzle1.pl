use strict;
use warnings;

use Data::Dumper;

use File::Basename;
use lib dirname (__FILE__);

use Bingo;

sub ltrim { my $s = shift; $s =~ s/^\s+//;       return $s };

open(my $input, "<", "input.txt");

my @rolls = split(/,/,<$input>);
my @lines = <$input>;

close($input);

splice(@lines, 0, 1); # remove empty line at the very beginning

my @boards = ();

for (my $i = 0; $i < @lines; $i += 6) {
	my @board = ();
	for (my $j = 0; $j < 5; $j++) {
		my @board_row = split(/ +/, ltrim($lines[$i+$j]), 5);
		push(@board, [ @board_row ]);
	}
	push(@boards, [ @board ]);
}

my @board_scores = ();

foreach (@boards) {
	my @score = ();
	for (my $i = 0; $i < 5; $i++) {
		$score[$i] = [0,0,0,0,0];
	}
	push(@board_scores, [ @score ]);
}

foreach (@rolls) {
	my $roll = $_;
	my $winner = -1;
	foreach my $i (0 .. $#boards) {
		$board_scores[$i] = Bingo::check_number($roll, $boards[$i], $board_scores[$i]);
		if (Bingo::check_win($board_scores[$i])) {
			$winner = $i;
			print("Winner: board $i!\n");
			last;
		}
	}
	if ($winner > -1) {
		my @victor = @{$boards[$winner]};
		my @victor_score = @{$board_scores[$winner]};
		my $victor_sum = 0;
		foreach my $i ( 0 .. $#victor ) {
			my @row = @{ $victor[$i] };
			foreach my $j ( 0 .. $#row ) {
				if ( $victor_score[$i][$j] == 0 ) {
					$victor_sum += $victor[$i][$j];
				}
			}
		}
		$victor_sum *= $roll;
		print("Final Score: $victor_sum\n");
		last;
	}
}
