use strict;
use warnings;

use List::Util qw(max);

open(my $input, "<", "input.txt");

my $first_line = <$input>;
my $line_len = length($first_line) - 1; # subtract 1 for newline char

seek($input, 0, 0);
my @lines = <$input>;

close($input);

sub get_common_digit {
	my ($position, @arr) = @_;
	my @counts = (0,0);
	foreach (@arr) {
		substr($_,$position,1) eq "0" ? $counts[0]++ : $counts[1]++;
	}
	if ($counts[0] > $counts[1]) {
		return 0;
	} else {
		return 1;
	}
}

for (my $i = 0; $i < $line_len; $i++) {
	if (@lines == 1) {
		last;	
	};
	my $common_val = get_common_digit($i, @lines);
	for my $index ( reverse 0 .. $#lines ) {
		if (substr($lines[$index],$i,1) != $common_val) {
			splice(@lines, $index, 1);
		}
	}
}

my $oxygen = eval("0b$lines[0]");

open(my $input, "<", "input.txt");
my @lines = <$input>;
close($input);

for (my $i = 0; $i < $line_len; $i++) {
	if (@lines == 1) {
		last;	
	};
	my $common_val = get_common_digit($i, @lines);
	for my $index ( reverse 0 .. $#lines ) {
		if (substr($lines[$index],$i,1) == $common_val) {
			splice(@lines, $index, 1);
		}
	}
}

my $CO2 = eval("0b$lines[0]");

my $life_supp = $oxygen * $CO2;
print("Life support: $life_supp\n");
