
=head1 NAME

total_cob_area.pl - calculate the area of a cob from phytomorph data

=head1 DESCRIPTION

 perl total_cob_area.pl -i phytomorphfile -r <resolution>

=head1 AUTHORS

Lukas Mueller <lam87@cornell.edu>
AC Repka <acr78@cornell.edu>

=cut


use strict;

use Getopt::Std;

our($opt_i, $opt_r);

getopts('i:r:');

if ($opt_r != 600 && $opt_r !=1200) { 
    print STDERR "Resolution has to be either 600 or 1200 dpi\n";
    exit();
}

my $file = $opt_i;

open(my $F, "<", $file) || die "can't open file $file\n";

while (<$F>) {
    chomp;
    my @fields = split /\t/;

    my $id = shift(@fields);

    my $on = shift(@fields);

    my $length = $fields[1005];

    print STDERR "ID: $id, #: $on, LENGTH: $length\n";

    my $length_mm = (($length * 25.4) / $opt_r);
    print "Length in mm : $length_mm\n";
    
    my $height = $length_mm /1000;

    my $total_area = 0;
    
    foreach my $n (0..999) {
	my $width = $fields[$n] * 25.4 / $opt_r;
	$total_area = $total_area + $width * $height;
    }

    print "$id\t$total_area\n";

}
