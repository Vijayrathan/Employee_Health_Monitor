import random
import time

from pymongo import MongoClient

tempList = []
try:
    conn = MongoClient()
    print("Connected successfully!!!")
except ConnectionError:
    print("Could not connect to MongoDB")

db = conn.database
collection = db.employee_health
while 1:
    for i in range(1, 101):
        temp = random.uniform(94, 102)
        pressureSys = random.randint(85, 160)
        pressureDia = random.randint(60, 130)
        breathing = random.randint(10, 40)
        glucose = random.randint(63, 250)
        heart = random.randint(60, 120)
        oxygen = random.randint(94, 99)
        cholestrol = random.randint(150, 260)
        id = random.sample(range(9999), 500)
        hba1c = random.uniform(3, 12)

        def diabetes():
            if glucose > 200:
                outcome = 1

            elif glucose > 180 and 140 < pressureSys < 110:
                outcome = 1

            elif hba1c > 9:
                outcome = 1

            else:
                outcome = 0

            return outcome


        def preDiabetes():
            if 140 < glucose < 200:
                outcome = 1
            else:
                outcome=0
            return outcome


        def chd():
            if pressureSys > 140 and cholestrol > 240:
                outcome = 1
            elif pressureSys>140 and heart > 82:
                outcome = 1
            else:
                outcome = 0
            return outcome


        def bronchi():
            if breathing > 30:
                outcome = 1
            else:
                outcome = 0
            return outcome


        def hypoxemia():
            if oxygen < 96:
                outcome = 1
            else:
                outcome = 0
            return outcome


        tempList = [
            {"emp_id": i,
             "temperature": float("{:.2f}".format(temp)),
             "pressure": f"{pressureSys}/{pressureDia}",
             "systole": pressureSys,
             "respiration": breathing,
             "glucose": glucose,
             "heart": heart,
             "oxygen": oxygen,
             "cholestrol": cholestrol,
             "hba1c": float("%.2f" % round(hba1c, 2)),
             "OutcomeDiabetes": diabetes(),
             "OutcomePrediabetes":preDiabetes(),
             "OutcomeChd": chd(),
             "OutcomeBronchi": bronchi(),
             "OutcomeHyp": hypoxemia(),
             }
        ]
        collection.insert_many(tempList)
    time.sleep(200)
    cursor = collection.find()
    for record in cursor:
        print(record)
