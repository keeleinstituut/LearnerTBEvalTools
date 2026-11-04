#!/usr/bin/perl -w
# Programm, mis sisendfaili põhjal eraldab teisest korpusest samad laused. Eeldab, et korpuses laused ei kordu.
# Kasutus ./textincluder.pl -t orig.conllu > output.conllu
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
my $pline="";
my %paisk=();
my $lipp=0;

while(<TBL>){
	$line=$_;
	chomp($line);
	$line =~ s/^\s+|\s+$//g;
	if ($line =~ /# text = (.*)$/) {
		$paisk{$1}=1;
	}
}
close(TBL) or die "$!\n";

$line="tühi";

while(<STDIN>){
	$pline=$line;
	$line=$_;
	chomp($line);
	$line =~ s/^\s+|\s+$//g;
	if ($line =~ m/# sent_id =/) {
		$lipp=0;
	}
	if ($line =~ m/# text = (.*)$/){
		if ($paisk{$1}) {
			$lipp=1;
			print $pline,"\n";
		} else {
			$lipp=0; 
		}
	}
	if ($lipp==1) {
		print $line,"\n";
	}
}
