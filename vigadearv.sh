#!/bin/bash
for (( i=1; i <= 5; ++i ))
do
cat ~/Programmid/LearnerTB/korpused_etapp_I/_lausestatistika.csv | awk -F';' -v i="$i" -e '$4 == i {print $2}'  >temp
cat originals.conllu |../includer.pl -t temp > tempgold.conllu
cat procorigfixedt.conllu |../textincluder.pl -t tempgold.conllu > tempproc.conllu
cat tempgold.conllu |udapy util.Wc
cat tempproc.conllu |sed '/^#/d' > origajutinevigaproc.txc
cat tempgold.conllu |sed '/^#/d' > origajutinevigagold.txc
java -jar ~/Programmid/MaltEval/dist-20141005/lib/MaltEval.jar --Metric "LA;UAS;LAS" --GroupBy Token -s origajutinevigaproc.txc -g origajutinevigagold.txc
done

cat ~/Programmid/LearnerTB/korpused_etapp_I/_lausestatistika.csv | awk -F';' -e '$4 >= 6 {print $2}'  >temp
cat originals.conllu |../includer.pl -t temp > tempgold.conllu
cat procorigfixedt.conllu |../textincluder.pl -t tempgold.conllu > tempproc.conllu
cat tempgold.conllu |udapy util.Wc
cat tempproc.conllu |sed '/^#/d' > origajutinevigaproc.txc
cat tempgold.conllu |sed '/^#/d' > origajutinevigagold.txc
java -jar ~/Programmid/MaltEval/dist-20141005/lib/MaltEval.jar --Metric "LA;UAS;LAS" --GroupBy Token -s origajutinevigaproc.txc -g origajutinevigagold.txc
