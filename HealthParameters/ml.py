import requests
import json

urlcomp = 'http://localhost:5001/mongodb'
headers = {'authorization': "Basic API Key Omitted", 'accept': "application/json", 'accept': "text/csv"}


rcomp = requests.get(urlcomp, headers=headers)
data = json.loads(rcomp.text)

DiabetesFile = open('C:\dev\\DiabetesPrediction.csv','a',encoding="utf8")
DiabetesFile.write('Glucose'+','+'pressure'+','+'hba1c'+','+'Outcome'+"\n")
for row in data:
    csv_row = str(row['glucose'])+','+str(row['systole'])+','+str(row['hba1c'])+','+str(row['OutcomeDiabetes'])
    DiabetesFile.write(csv_row + "\n")

PrediabetesFile = open('C:\dev\\PreDiabetesPrediction.csv','a',encoding="utf8")
PrediabetesFile.write('Glucose'+','+'pressure'+','+'hba1c'+','+'Outcome'+"\n")
for row in data:
    csv_row = str(row['glucose'])+','+str(row['systole'])+','+str(row['hba1c'])+','+str(row['OutcomePrediabetes'])
    PrediabetesFile.write(csv_row + "\n")

ChdFile = open('C:\dev\\ChdPrediction.csv','a',encoding="utf8")
ChdFile.write('pressure'+','+'cholesterol'+','+'heartrate'+','+'Outcome'"\n")
for row in data:
    csv_row = str(row['systole'])+','+str(row['cholestrol'])+','+str(row['heart'])+','+str(row['OutcomeChd'])
    ChdFile.write(csv_row + "\n")

BronchiFile = open('C:\dev\\BronchiectasisPrediction.csv','a',encoding="utf8")
BronchiFile.write('breathing'+','+'Outcome'"\n")
for row in data:
    csv_row = str(row['respiration'])+','+str(row['OutcomeBronchi'])
    BronchiFile.write(csv_row + "\n")

HypoFile = open('C:\dev\\HypoxemiaPrediction.csv','a',encoding="utf8")
HypoFile.write('oxygenSat'+','+'Outcome'"\n")
for row in data:
    csv_row = str(row['oxygen'])+','+str(row['OutcomeHyp'])
    HypoFile.write(csv_row + "\n")

AllFile = open('C:\dev\\All.csv','a',encoding="utf8")
AllFile.write('Glucose'+','+'pressure'+','+'temperature'','+'cholesterol'+','+'heartrate'+','+'oxygenrate'"\n")
for row in data:
    csv_row = str(row['glucose'])+','+str(row['pressure'])+','+str(row['temperature'])+','+str(row['cholestrol'])+','+str(row['heart'])+','+str(row['oxygen'])
    AllFile.write(csv_row + "\n")