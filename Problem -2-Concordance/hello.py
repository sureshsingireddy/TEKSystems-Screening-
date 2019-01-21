
############
#Author: Suresh Reddy Singireddy
#Referneces 
#https://programminghistorian.org/en/lessons/counting-frequencies#python-dictionaries
#https://stackoverflow.com/
#http://cs.brown.edu/courses/cs0931/2012/lectures/LEC2-2.pdf
############

###read the file which has the sample text###
#Given an arbitrary text document written in English, write a program that will generate a concordance, 
#i.e. an alphabetical list of all word occurrences, labeled with word frequencies. Bonus: label each word 
#with the sentence numbers in which each occurrence appeared.

file = open("yale.text", "r") 
text = file.read()
#print (text)

### read the file into words ###

def lines(text):
	String_s = text.replace('\n', ' ')
	import re
	String_s = re.compile("(?<!\w\.\w.)(?<![A-Z][a-z]\.)(?<=\.|\?)\s").split(String_s)
	return String_s

text_line=lines(text)

#print (text_line)

### spilt the text into words ###

def split_line(String_s):
	String = String_s.replace(',', '')
	String = String.replace('.', '')
	String = String.rstrip('.')
	Words=String.lower()
	Words=Words.split(' ')
	return Words

wordfreq = {}
count = 0

#sl=split_line(text_line)

#print(sl)

### Count the each word occurance ###

for s in text_line:
    count=count+1
    #print (s)
    for w in split_line(s):
        if len(w)<1:continue
        if w not in wordfreq:
            wordfreq[w]=1, [count]
        else:
            cnt,l=wordfreq[w]
            cnt=cnt+1
            l.append(count)
            wordfreq[w]=cnt,l
#print (wordfreq) 

#print (dict(zip(wordfreq)))
#print (dict(wordfreq))

### print the data in alphabetical order with number of occurances ###

for data in sorted(wordfreq):
        print (data,'{', wordfreq[data][0],':', ','.join(map(str, wordfreq[data][1])),'}')

