use strict;
use warnings;

my $inc_count = 0;

open(my $input, "<", "input.txt") or die "Can't open input.txt";

my @lines = <$input>;

close($input);

sub sum_three {
	my $index = @_;
	return $lines[$index] + $lines[$index+1] + $lines[$index+2];
}

my @sums = ();

for (my $i = 0; $i < $#lines; $i++) {
	my $temp_sum = $lines[$i] + $lines[$i+1] + $lines[$i+2];
	push(@sums, $temp_sum);
	if ($i != 0 and $sums[$i] > $sums[$i-1]) {
		$inc_count++;
	}
}

print($inc_count."\n");
