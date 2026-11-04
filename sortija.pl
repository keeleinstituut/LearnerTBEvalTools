#!/usr/bin/perl -w
#Programm, mis trükib õppijakeele korpusest välja kas õppijakeelsed laused (-o), parandatud laused (-c) või osaliselt parandatud laused (-p)
# Kaili Müürisep 2026 


use strict;
use utf8;

use Getopt::Std;
# -t Arg 

my %option=();
my $phrase="";
getopts("cop",\%option);


if ($option{c}) {$phrase="corrected";}
elsif ($option{o}) {$phrase="original";}
elsif ($option{p}) {$phrase="partial";}
else { die("pane mõni lipp \n");} 


my $line="";
my %paisk=();
my $lipp=0;

while(<STDIN>){
	$line=$_;
	chomp($line);
	$line =~ s/^\s+|\s+$//g;
	if ($line =~ m/^# sent_id = \S+/){
		if ( $line =~ m/$phrase/){
			$lipp=1;
		} else {
			$lipp=0;
		}
	}
	if ($lipp==1) {
		print $line,"\n";
	}
}
