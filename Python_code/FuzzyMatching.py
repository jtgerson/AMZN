# Print Welcome Message
#print ('helo world')

#python -m pip install fuzzywuzzy

from fuzzywuzzy import fuzz 
from fuzzywuzzy import process

from difflib import SequenceMatcher as SM 


print(fuzz.ratio("Acme Factory", "Acme Factory Inc."))

#by using the partial ratio, it can determine that the two are really identical
print(fuzz.partial_ratio("Acme Factory", "Acme Factory Inc."))

#100% Score
print(fuzz.ratio("Barack Obama", "Barack Obama")) #100% Score

print(fuzz.ratio("Barack Obama", "Barack H. Obama")) #89% score

print(fuzz.ratio("Barack H Obama", "Barack H. Obama")) #97% score

#partial ratio does work as well as ratio because the extra token is in the middle
print(fuzz.partial_ratio("Barack H Obama", "Barack H. Obama")) #93% score

#The token_* functions split the string on white-spaces, lowercase everything and get rid of non-alpha non-numeric characters, which means punctuation is ignored (as well as weird unicode symbols)
print(fuzz.token_sort_ratio('Barack Obama', 'Barack H. Obama')) #92% score extra letter in middle lowers score with sore

print(fuzz.token_set_ratio('Barack Obama', 'Barack H. Obama')) # 100 token_set recognizes 

print(fuzz.token_sort_ratio('Barack H Obama', 'Barack H. Obama')) # 100

print(fuzz.token_set_ratio('Barack H Obama', 'Barack H. Obama','Barack . Obama')) # 100 

query = 'Barack Obama'
choices = ['Barack H Obama', 'Barack H. Obama' , 'B. Obama']
# Get a list of matches ordered by score, default limit to 5
print(process.extract(query, choices))

# If we want only the top one
print(process.extractOne(query, choices))

#text matching - has to be exact
data1 = "Josh", "Bob", "Sameer", "Andrew"
data2 = "Josh", "Bob", "sameer", "Ryan"
Matched = (set(data1) & set(data2))
Matched = print(set(data1).intersection(data2)) #alternative method
print(Matched)