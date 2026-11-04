#!/usr/bin/perl -w
# Programm sõnaliigi erinevuste loendamiseks
# käivitamine ./posconfusion.pl -p analüüsikorpusepos -g Kuldkorpusepos
# autor Kaili Müürisep

use strict;
use utf8;

use Getopt::Std;
# -g Arg -p Arg

my %option=();

getopt("g:p:",\%option);

if ($option{g}){
    print STDERR "loeb kuldkorpuse sõnaliigid $option{g}\n";
} else {
    die "-g fail on vajalik\n";
}    

open(TBL, "< $option{g}") or die "fail ei avanenud: $option{g} $!\n";

my @lines;

push @lines, 
 split while <TBL>;
 
close(TBL) or die "$!\n";

if ($option{p}){
    print STDERR "loeb analüüsikorpuse sõnaliigid $option{p}\n";
} else {
    die "-g fail on vajalik\n";
}    

open(TBL, "< $option{p}") or die "fail ei avanenud: $option{p} $!\n";

my @plines;

push @plines, 
 split while <TBL>;

close(TBL) or die "$!\n";

if ($#lines!=$#plines){
	print "ridade arv ei klapi!\n";
	die;
}

my $i=0;

my %paisk=();

while ($i<=$#lines) {
	if ($lines[$i] ne $plines[$i]){
		$paisk{$plines[$i]."-".$lines[$i]}++;
	}
	$i++;
}

for my $key ( sort { $paisk{$a} <=> $paisk{$b} } keys %paisk ) { 
   print $key, " => ", $paisk{$key},"\n";
}

