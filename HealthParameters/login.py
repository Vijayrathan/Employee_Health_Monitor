import random

from pymongo import MongoClient
tempList=[]
try:
    conn = MongoClient()
    print("Connected successfully!!!")
except:
    print("Could not connect to MongoDB")
db = conn.database
collection=db.employee_ids
for i in range(0,101):
    emp_id=i
    pwd=random.randint(1001,9999)
    hashed_pwd=hash(pwd)
    tempList.append({"_id":i,"emp_id": emp_id,"pwd" : hashed_pwd})

collection.insert_many(tempList)
cursor = collection.find()
for record in cursor:
    print(record)