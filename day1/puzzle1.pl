use strict;

my $inc_count = 0;
my $prev_line = -1;

open(my $input, "<", "input.txt");

while (my $line = <$input>) {
	if ($line > $prev_line and $prev_line != -1) {
		$inc_count++;
	}
}

close($input);

print($inc_count);
