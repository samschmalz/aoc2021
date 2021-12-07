use strict;
use warnings;

my $aim = 0;
my $depth = 0;
my $position = 0;

open(my $input, "<", "input.txt");

while (my $line = <$input>) {
	my ($direction, $dist) = split(/\s/,$line,2);

	if ($direction eq "up") {
		$aim -= $dist;
	} elsif ($direction eq "down") {
		$aim += $dist;
	} elsif ($direction eq "forward") {
		$position += $dist;
		$depth += $aim*$dist;
	}
}

close($input);

my $answer = $depth * $position;

print($answer."\n");
