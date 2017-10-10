# PANDAS
import pandas as pd
import numpy as np

df = pd.read_csv('/Users/jggerson/Desktop/HP1.csv') #import data from location
df1 = pd.read_csv('/Users/jggerson/Desktop/HP_Listen.csv')

#print(df.head(20)) #print first 20 lines of each field
#print(df.parent_product_id.unique()) #print unique values in parent_product_id field


#print(df.shape) #counts rows and columns

#print(df.units.sum()) #sum units


#Extract units by sale type
#print(df.groupby(by=['sale_type'])['units'].sum()) #group units by sale type


print(df.pivot_table("units",index='sale_type',columns=['marketplace_name'],aggfunc='sum')) #sum units by sale type and marketplace


#print(df.loc[df['sale_type'] =="AL", 'units'].sum()) #sum AL Units

#print(df.groupby('sale_type')['units'].sum()["AL"]) #sum AL Units (alternatively)

#print((df1.seconds.sum())/60) #total minutes consumed

#df1.min=(df1.seconds.sum())/60 #df1.min converst my seconds to minutes

print(df1.groupby(by=['product_royalty_earner'])['seconds'].sum()) minutes by earner
