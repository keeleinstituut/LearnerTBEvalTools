#!/bin/sh
cat ~/Programmid/LearnerTB/korpused_etapp_I/metaandmed_udpipe.csv | awk -F'\t' -e '$8 ~ /\[.*WS.*\]/ {print $1}' > ajutineviga_nr.txt 
cat corrected.conllu |../includer.pl -t ajutineviga_nr.txt > corrajutinevigagold.conllu
cat procfixcor.conllu |../textincluder.pl -t corrajutinevigagold.conllu > corrajutinevigaproc.conllu
cat corrajutinevigagold.conllu |udapy util.Wc
cat corrajutinevigaproc.conllu |sed '/^#/d' > corrajutinevigaproc.txc
cat corrajutinevigagold.conllu |sed '/^#/d' > corrajutinevigagold.txc
java -jar ~/Programmid/MaltEval/dist-20141005/lib/MaltEval.jar --Metric "LA;UAS;LAS" --GroupBy Token -s corrajutinevigaproc.txc -g corrajutinevigagold.txc 
