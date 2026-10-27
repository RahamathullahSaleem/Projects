import mysql.connector
import pandas as pd
import numpy as np
import requests
# Dataframe
customers_df = pd.read_csv(r'Input/customers.csv')
products_df = pd.read_csv(r'Input/products.csv')
orders_df = pd.read_csv(r'Input/orders.csv')
print(customers_df)
print(products_df)
print(orders_df)

#Clean Customers dats
#remove extra spaces
Spaceremove_cdf = customers_df['customer_name','email','city'].str.strip()
print(Spaceremove_cdf)
#First letter captical
Title_cdf  = customers_df['customer_name','email','city'].str.title()
print(Title_cdf)
#null Values changed as unknown
Replace_Missing_cdf = customers_df['customer_name','email','city'].fillna('unknown')
print(Replace_Missing_cdf)
#Duplicate rows removed
Remove_duplicate_cdf = customers_df.drop_duplicates()
print(Remove_duplicate_cdf)
Sort1 = customers_df.sort_values('customer_id',ascending=True)

#Clean Products Data
#remove extra spaces
Spaceremove_pdf= products_df['product_name','category'].str.strip()
print(Spaceremove_pdf)
#First letter captical
Title_pdf  = products_df['product_name','category'].str.title()
print(Title_pdf)
#null Values changed as unknown
Replace_Missing_pdf = products_df['product_name','category','price'].fillna('unknown')
print(Replace_Missing_pdf)
#Duplicate rows removed
Remove_duplicate_pdf = products_df.drop_duplicates()
print(Remove_duplicate_pdf)
Sort2 = products_df.sort_values('product_id',ascending=True)

#Clean Orders Data
#remove extra spaces
Spaceremove_odf=orders_df['Order_ID','Customer_ID','Product_ID','Order_Status','status'].str.strip
print(Spaceremove_odf)
#change negative values
greater_than_zero = orders_df['Quantity', 'Price']>=0
print(greater_than_zero)
#Valid date formate
valid_date = orders_df['order_date'].notna()
print(valid_date)
#remove duplicate Values
unique_order_id = orders_df['Order_ID'].duplicated(keep=False)
print(unique_order_id)
Sort3 = orders_df.sort_values('order_id',ascending=True)

#API
APIlink = requests.get('https://jsonplaceholder.typicode.com/users')
json_Convert =APIlink.json()
print('Json converted')
print(type(json_Convert))
#Convert API Response into Usable Data
data = pd.DataFrame(APIlink)
APIdata = requests.get('https://jsonplaceholder.typicode.com/users').json()
for data in APIdata:
    print(data['api_customer_id'],data['api_customer_name'],data['api_email'],data['api_city'])

#Again change to Csv file
customers_df.to_csv("Output_file/customer_cleaned.csv",index = False)
print('csv file created')
products_df.to_csv("Output_file/product_cleaned.csv",index = False)
print('csv file created')
orders_df.to_csv("Output_file/order_cleaned.csv",index = False)
print('csv file created')

#Final Validation
#Customer table
sourceemp1 = len(customers_df)
targetemp1 = len(Sort1)
if sourceemp1 == targetemp1:
    print(sourceemp1)
else:
    print('rows missing')
#Product Table
sourceemp2 = len(products_df)
targetemp2 = len(Sort2)
if sourceemp2 == targetemp2:
    print(sourceemp2)
else:
    print('rows missing')
#Order Table
sourceemp3 = len(products_df)
targetemp3 = len(Sort3)
if sourceemp3 == targetemp3:
    print(sourceemp3)
else:
    print('rows missing')



