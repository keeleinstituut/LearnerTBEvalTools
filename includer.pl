#!/usr/bin/perl -w
# Programm trükib välja etteantud lauseidentifikaatoriga laused
# ./includer -t komaviga.txt
# Kaili Müürisep 2026


use strict;
use utf8;

use Getopt::Std;
# -t Arg 

my %option=();

getopt("t:",\%option);

if ($option{t}){
    print STDERR "loeb tabeli $option{t}\n";
} else {
    die "-t tabel on vajalik\n";
}    

open(TBL, "< $option{t}") or die "tabel ei avanenud: $option{t} $!\n";

my $line="";
my %paisk=();
my $lipp=0;

while(<TBL>){
	$line=$_;
	chomp($line);
	$line =~ s/^\s+|\s+$//g;
	$paisk{$line}=1;
}
close(TBL) or die "$!\n";

while(<STDIN>){
	$line=$_;
	chomp($line);
	$line =~ s/^\s+|\s+$//g;
	if ($line =~ m/^# sent_id = (\d+_\d+)_/){
		if ($paisk{$1}) {
			$lipp=1;
		} else {
			$lipp=0;
		}
	}
	if ($lipp==1) {
		print $line,"\n";
	}
}
