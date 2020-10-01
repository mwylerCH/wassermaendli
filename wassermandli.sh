#!/bin/bash

### script software that produces identity by waterman smith algorithm form emboss

# help printhout for if "-h" is used
if [ "$1" == "-h" ]; then
  echo -e "Usage:  \e[1m`basename $0`\e[0m \e[4mGene.LIST\e[0m \e[4mFILE.fasta\e[0m"
  exit 0
fi

# check number of arguments
if [ "$#" -ne 3 ]; then
    echo -e "Illegal number of parameters! Run\n\t \e[1m`basename $0` -h\e[0m"
    exit 0
fi

# Create output folder and remove temporary files
rm -r WATER_align
rm tmp_primo.fa
rm tmp_secondo.fa
mkdir WATER_align
rm *.fai
 

# file of interested gene
GENES1=$1
GENES2=$2
# multifasta containing gene
FASTA=$3

# make pairing file and remove pairs of same gene
join -j 999999 -o 1.1,2.1 $GENES1 $GENES2 | perl -p -e 's/ /\t/g' | awk '{if($1 != $2) print $0}' > WATER_align/Pairs.txt


# read in and start LOOP
cat WATER_align/Pairs.txt | while read line ; do


# define pairs
PRIMO=`echo $line | awk '{print $1}'`
SECONDO=`echo $line | awk '{print $2}'`


# extract fasta
samtools faidx $FASTA $PRIMO > tmp_primo.fa
samtools faidx $FASTA $SECONDO > tmp_secondo.fa

# align with 'water'
water tmp_primo.fa tmp_secondo.fa -gapopen 10  -gapextend 0.5 -outfile tmp_WATER

# extract identity (in %)
ID=`fgrep 'Identity' tmp_WATER | sed -e 's/).*//g' | sed 's/.*(//g' | sed 's/%//g'`


#similarity (in %)
SIM=`fgrep 'Similarity' tmp_WATER | sed -e 's/).*//g' | sed 's/.*(//g' | sed 's/%//g'`

#gaps (in %)
GAP=`fgrep 'Gaps' tmp_WATER | sed -e 's/).*//g' | sed 's/.*(//g' | sed 's/%//g'`

#score
SCORE=`fgrep 'Score' tmp_WATER | sed 's/.*: //g'`


## write output
echo "$PRIMO'\t'$SECONDO'\t'$ID'\t'$SIM'\t'$GAP'\t'$SCORE"

# keep copy of alignment 
OUT_NAME=`echo WATER_align/${PRIMO}_${SECONDO}`
cp tmp_WATER $OUT_NAME

done


