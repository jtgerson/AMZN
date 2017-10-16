import pandas as pd
import numpy as np
from pandas import DataFrame
from fuzzywuzzy import fuzz
from fuzzywuzzy import process
import csv

#loads data into pandas
data = pd.read_csv('C:/Users/jggerson/Desktop/name1.csv')
data1 = pd.read_csv('C:/Users/jggerson/Desktop/name2.csv')

#ratio of confidence on match
#print(fuzz.ratio(data.name,data1.name))
#print(fuzz.token_sort_ratio(data.name,data1.name))
#print(fuzz.token_set_ratio(data.name,data1.name))

#shows matched items in dataframe format
matched = [(set(data.name) & set(data1.name))]
df = pd.DataFrame(matched)
print(df)
#export print dataframe to csv
df.to_csv('C:/Users/jggerson/Desktop/josh12.csv')


#show matched names
matched = set(data1.name).intersection(data.name) #alternative method
print(matched)

#print mathced items in list form
#with open('C:/Users/jggerson/Desktop/josh20.csv','w') as f:
	#wr = csv.writer(f, delimiter="\n")
	#wr.writerow(matched)

#show unmatched names
unmatched= set(data.name).symmetric_difference(set(data1.name))
print(unmatched)

#list unmatched items in list form 
#with open('C:/Users/jggerson/Desktop/josh21.csv','w') as f:
	#wr = csv.writer(f, delimiter="\n")
	#wr.writerow(unmatched)

#export print format to csv
#df1.to_csv('C:/Users/jggerson/Desktop/josh2.csv',index=False)


# print to one csv in separate CSV and add header to columns












