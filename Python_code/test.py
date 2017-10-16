import pandas as pd
import numpy as np
from pandas import DataFrame
from fuzzywuzzy import fuzz
from fuzzywuzzy import process
import csv

#loads data into pandas
data = pd.read_csv('C:/Users/jggerson/Desktop/name1.csv')
data1 = pd.read_csv('C:/Users/jggerson/Desktop/name2.csv')


match = set(data1.name).intersection(data.name) #alternative method
print(match)


















