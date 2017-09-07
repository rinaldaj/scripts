#!/bin/perl
use warnings;
#use autodie;

$args = join(' ',@ARGV);
if ($args =~ m/-a/) {
	open( ASSIGNLIST,">>",$ENV{"HOME"}."/.assignments");
	if($args=~m/\s*-a([a-zA-Z ]+)\s+(\d+\.?\d*)\s*$/){
		$hours = $2;
		$assignment = $1;
		print ASSIGNLIST "$hours $assignment\n";
	} else {
		print("-a flag useage: -a assignmentName hoursOfAssignment\n");
	}	
	close(ASSIGNLIST);
} elsif($args =~ m/-d/) {
	if($args=~m/-d\s*([a-zA-Z_ ]+)/){
		open(READ,"<",$ENV{"HOME"}."/.assignments");
		$assignment = $1;
		@text = <READ>;
		@new = ();
		foreach $tmp (@text) {
			if (not $tmp =~m/$assignment/){
				push @new, $tmp;
			}
		}
		close(READ);
		open(WRITE,'>',$ENV{"HOME"}."/.assignments");
		print WRITE "@new";
		close(WRITE);
	} else {
		print("-d useage: assignmentName");
	}
} else {
	open(READ,"<",$ENV{"HOME"}."/.assignments");
	while ($i =  <READ>) {
		print "$i";
	}
	close(READ);
}

