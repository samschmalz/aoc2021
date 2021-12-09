use strict;
use warnings;

open(my $input, "<", "input.txt");

my $firstline = <$input>;
my $line_len = length($firstline) - 1; # subtract 1 for newline

my @counts = ();
for (my $i = 0; $i < $line_len; $i++) {
	$counts[$i] = [0,0];
}

seek($input, 0, 0); # reset to beginning of file

while (my $line = <$input>) {
	my $remainder = $line;
	for (my $j = $line_len - 1; $j > 0; $j--) {
		my $divisor = 10**$j;
		my $digit = int($remainder/$divisor);
		my $position = $line_len - ($j + 1);
		$counts[$position][int($digit)]++;

		$remainder = substr($remainder, 1);
	}
}

close($input);

my $gamma = "";
my $epsilon = "";
for (my $i = 0; $i < $line_len; $i++) {
	$gamma = $counts[$i][0] > $counts[$i][1] ? $gamma."0" : $gamma."1";
	$epsilon = $counts[$i][0] > $counts[$i][1] ? $epsilon."1" : $epsilon."0";
}
my $gamma_dec = eval("0b$gamma");
my $epsilon_dec = eval("0b$epsilon");
print("Gamma: $gamma\n");
print("Epsilon: $epsilon\n");
my $power = $gamma_dec * $epsilon_dec;
print("Power: $power\n");
