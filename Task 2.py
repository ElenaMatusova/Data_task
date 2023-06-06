import pandas as pd
import pyodbc as od
import re

# lists = [x for x in od.drivers()]
# print(lists)

# For reading CSV is used Microsoft Access Text Driver (*.txt, *.csv)
conn_str = (
     r'DRIVER={Microsoft Access Text Driver (*.txt, *.csv)};'
     r'DBQ=C:///Documents//tasks;')
cnxn = od.connect(conn_str, autocommit=True)
crs = cnxn.cursor()
def df_creation(filename):

    crs.execute('SELECT * FROM' + filename) 
    rows = [list(i) for i in crs.fetchall()]
    df = pd.DataFrame(rows)
    return df


df_1 = df_creation('Data_part_1.csv')
df_1 = df_1.rename(columns=df_1.iloc[0]).loc[1:]
df_2 = df_creation('Data_part_2.csv')
df_2.columns = df_1.columns
df_3 = df_creation('Data_part_3.csv')
df_3.columns = df_1.columns
df_4 = pd.concat([df_1, df_2, df_3], sort=False)

#local version 
# df_1 = pd.read_csv('C:\\Users\\olena.matusova\\OneDrive - Fractal Analytics Pvt. Ltd\\Documents\\Coursera\\tasks\\Data_part_1.csv', sep=";")
# df_2 = pd.read_csv('C:\\Users\\olena.matusova\\OneDrive - Fractal Analytics Pvt. Ltd\\Documents\\Coursera\\tasks\\Data_part_2.csv', sep=";")
# df_2.columns = df_1.columns
# df_3 = pd.read_csv('C:\\Users\\olena.matusova\\OneDrive - Fractal Analytics Pvt. Ltd\\Documents\\Coursera\\tasks\\Data_part_3.csv', sep=";")
# df_3.columns = df_1.columns
# df_4 = pd.concat([df_1, df_2, df_3], sort=False)

#count people in each company
df_4['people'] = df_4['first_name']+ (' ') + df_4['last_name']
df_count_people = df_4.groupby('company_name')['people'].count()

#calculation fraction of domain
df_4['email_part'] = df_4['email'].str.split('@').str[1]
df_5 = (df_4['email_part'].value_counts().div(df_4['email'].str.count('@').sum())).mul(100)


