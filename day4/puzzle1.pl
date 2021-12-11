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
	foreach my $i (0 .. $#boards) {
		$board_scores[$i] = Bingo::check_number($roll, $boards[$i], $board_scores[$i]);
		print Dumper $board_scores[$i];
=begin
		if (Bingo::check_win($board_scores[$i])) {
			print("Winner!\n");
		}
=cut
	}
}
