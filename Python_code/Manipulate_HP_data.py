# PANDAS
import pandas as pd
# numpy
import numpy as np

#installing modules
#python -m pip install fuzzywuzzy



#import data from location
df = pd.read_csv('/Users/jggerson/Desktop/HP1.csv') 
df1 = pd.read_csv('/Users/jggerson/Desktop/HP_Listen.csv')
#cleanse date by dropping October, and Fanstasic Beasts
df = df.drop(df[df.yr_mth_name == "10/1/2017"].index)
#df = df.drop(df[df.product_royalty_earner == "Pottermore Limited - Fantastic Beasts"].index)
#df = df.drop(df[df.product_royalty_earner == "Pottermore Limited / German Translations / Phantastische Tierwesen"].index)

#print first 20 lines of each field
#print(df.head(20)) 

#print unique values in parent_product_id field
#print(df.parent_product_id.unique()) 

#counts rows and columns
#print(df.shape) 

#sum units
print(df.units.sum()) 

#Extract units by sale type
#print(df.groupby(by=['sale_type'])['units'].sum()) 

#Extract units by royalty earner
print(df.groupby(by=['product_royalty_earner'])['units'].sum()) 

#sum units by sale type and marketplace
#print(df.pivot_table("units",index='sale_type',columns=['marketplace_name'],aggfunc='sum')) 

#sum units by royalty earner and marketplace
#print(df.pivot_table("units",index='product_royalty_earner',columns=['marketplace_name'],aggfunc='sum')) 

#sum AL Units
#print(df.loc[df['sale_type'] =="AL", 'units'].sum())

#sum AL Units (alternatively)
#print(df.groupby('sale_type')['units'].sum()["AL"]) 

#total minutes consumed
#print((df1.seconds.sum())/60) 

#converts my seconds to minutes
#df1.min=(df1.seconds.sum())/60 #df1.min 

#minutes by earner
#print(df1.groupby(by=['product_royalty_earner'])['seconds'].sum()) 

#sum units other than AL
#print(df.loc[df['sale_type'] !="AL", 'units'].sum()) 

#units not AL and not ALC sale type
#print(df.loc[(df['sale_type'] !="AL") & (df['sale_type'] !="ALC"), 'units'].sum())  

#sum units that aren't in 10/1/2017 and not fantastic beasts
#print(df.loc[(df['yr_mth_name'] !="10/1/2017") & (df['product_royalty_earner'] !="Pottermore Limited - Fantastic Beasts") & (df['product_royalty_earner'] !="Pottermore Limited / German Translations / Phantastische Tierwesen"), 'units'].sum())

