import csv

f = open('C:/Users/jggerson/Desktop/HP.csv')

csv_f = csv.reader(f)

for row in csv_f:
	print (row)

f.close()


import pandas as pd
import numpy as np
df= pd.read_csv('C:/Users/jggerson/Desktop/HP.csv')














