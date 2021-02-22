import csv, smtplib, ssl
import time

message = """Subject: Daily Health

Hi employee, Glucose:{Glucose} 
                Temperature:{temperature}
                pressure:{pressure}
                Cholesterol:{cholesterol}
                Heart rate:{heartrate}
                Oxygen rate:{oxygenrate}"""


from_address = "vijayrathank@gmail.com"
password = input("Type your password and press enter: ")

context = ssl.create_default_context()
with smtplib.SMTP_SSL("smtp.gmail.com", 465, context=context) as server:
    server.login(from_address, password)
    with open("C:\dev\\All.csv") as file:
        reader = csv.reader(file)
        next(reader)  # Skip header row
        email = "vijayrathank@gmail.com"


        for Glucose, pressure, temperature, cholesterol, heartrate , oxygenrate in reader:
            server.sendmail(
                from_address,
                email,
                message.format(Glucose=Glucose,pressure=pressure,temperature=temperature,cholesterol=cholesterol,heartrate=heartrate,oxygenrate=oxygenrate),
            )
            time.sleep(30)
