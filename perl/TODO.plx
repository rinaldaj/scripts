#!/bin/perl
use warnings;
#use autodie;

$args = join(' ',@ARGV);
if ($args =~ m/-a/) {
	open( ASSIGNLIST,">>",$ENV{"HOME"}."/.assignments");
	if($args=~m/\s*-a\s*(\d+\.?\d*)\s+(\d?\d[-\/.]\d?\d[-\/.]\d+)\s+(.*)\s*$/){
		$hours = $1;
		$dueDate = $2;
		$assignment = $3;
		print ASSIGNLIST " $dueDate $hours $assignment\n";
	} else {
		print("-a flag useage: -a hoursOfAssignment MM-DD-YY assignement name \n");
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
				push @new,$tmp;
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
		$tmp = $i;
		$tmp =~ s/[ ]+/ /;
		print "$tmp";
	}
	close(READ);
}

