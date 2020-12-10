#!/bin/bash

ynet="https://www.ynetnews.com/category/3082"
article="https://www.ynetnews.com/article/[0-9a-zA-Z]{9}(?=\")"

bibi="Netanyahu"
benny="Gantz"
web_page="3082"

wget $ynet
grep -oP $article $web_page | sort | uniq >> article_links.txt
rm $web_page

wc -l < article_links.txt >> results.csv

while read line 
do
	wget $line
       	web_page_i=$(echo $line | cut -f5 -d/)	

	B=$(grep -F -c $bibi $web_page_i)
	G=$(grep -F -c $benny $web_page_i)
	rm $web_page_i

	if [ 0 -eq $B ] && [ 0 -eq $G ] 
	then
		echo "$line, -" >> results.csv	
	else
		echo "$line, $bibi, $B, $benny, $G" >> results.csv 		
	fi


done < article_links.txt	
rm article_links.txt






















