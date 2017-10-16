import pandas as pd
import numpy as np
from pandas import DataFrame
from fuzzywuzzy import fuzz
from fuzzywuzzy import process
import csv

#loads data into pandas
data = pd.read_csv('C:/Users/jggerson/Desktop/name1.csv')

#shows headers and data
print(data.head)

#shows count, unique values and top name and frquency for specific column
print(data.names.describe())

#shows top 3 names of a specfic column
print(data['names'][:3])

#select multiple columns limit to top 2
print(data[['names', 'age']][:2])

#changes NaN fields to whatever such as n/a or ""
data.names = data.names.fillna("n/a")
print(data.names)

#fills blank ages with mean
data.age = data.age.fillna(data.age.mean())
print(data.age)

#drop rows with any n/a
#data.dropna()

#drop rows with all n/a values
#data.dropna(how='all')

#drop rows where there is no information on age
#print(data.dropna(subset=['age']))

#drop columns with all n/a values
#data.dropna(axis=1, how="all")

#drop columns with any n/a values
#data.dropna(axis=1, how="any")


#do normalizing above before the string data below

#normalizing dataset.
# changing strings to numberic values. want integer value
#data = pd.read_csv('C:/Users/jggerson/Desktop/name1.csv', dtype={'age': int})

# make age a string and not a number
#data = pd.read_csv('C:/Users/jggerson/Desktop/name1.csv', dtype={'age': str})

#Change casing to upper
data['names'].str.upper()

#Change casing to upper
print(data['names'].str.lower())

#rename columns
data.rename(columns={'names':'first_name','age':"years_old"})

#export back to csv
data.to_csv('C:/Users/jggerson/Desktop/new.csv', encoding='utf-8')












