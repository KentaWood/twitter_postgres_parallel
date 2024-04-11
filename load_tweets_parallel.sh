#!/bin/sh

files=$(find data/*)

echo '================================================================================'
echo 'load pg_denormalized'
echo '================================================================================'
	echo "$files" |  time parallel ./load_denormalized.sh
echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
	echo "$files" |  time parallel python3 -u load_tweets.py --db postgresql://postgres:pass@localhost:1331/ --inputs $file
echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
	echo "$files" | time parallel python3 -u load_tweets_batch.py --db postgresql://postgres:pass@localhost:1338/ --inputs $file

