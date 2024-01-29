import pandas as pd
from sqlalchemy import create_engine
df = pd.read_csv('green_tripdata_2019-09.csv', nrows=100)

df['tpep_pickup_datetime'] = pd.to_datetime(df.lpep_pickup_datetime)
df['tpep_dropoff_datetime'] = pd.to_datetime(df.lpep_dropoff_datetime)
print(df)
engine = create_engine('postgresql+psycopg2://postgres:tiger10@localhost:5432/green_tripdata')
engine.connect()
zones = pd.read_csv('taxi+_zone_lookup.csv')
zones.to_sql(name='zones', con=engine)
df = pd.read_csv('taxi+_zone_lookup.csv')
pd.io.sql.get_schema(df, name='green_tripdata', con=engine)
df_iterator = pd.read_csv('green_tripdata_2019-09.csv', iterator=True, chunksize=10000)
df = next(df_iterator)

df['tpep_pickup_datetime'] = pd.to_datetime(df.lpep_pickup_datetime)
df['tpep_dropoff_datetime'] = pd.to_datetime(df.lpep_dropoff_datetime)

df.head(n=0).to_sql(name='green_tripdata', con=engine, if_exists='replace')
df.to_sql(name='green_tripdata', con=engine, if_exists='append')
while True:
    df = next(df_iterator)
    df['tpep_pickup_datetime'] = pd.to_datetime(df.lpep_pickup_datetime)
    df['tpep_dropoff_datetime'] = pd.to_datetime(df.lpep_dropoff_datetime)
    df.to_sql(name='green_tripdata', con=engine, if_exists='append')

    
