import datetime
import random
import matplotlib.pyplot as plt
import csv

file = r"C:\Users\Brandon\Desktop\parking.csv"
monday_count = 0
tuesday_count = 0
wednesday_count = 0
thursday_count = 0
friday_count = 0
saturday_count = 0
sunday_count = 0

with open(file) as csvfile:
    readCSV = csv.reader(csvfile, delimiter=',')
    for row in readCSV:
        if row[0] == 'MONDAY':
            monday_count += 1
        if row[0] == 'TUESDAY':
            tuesday_count += 1
        if row[0] == 'WEDNESDAY':
            wednesday_count += 1
        if row[0] == 'THURSDAY':
            thursday_count += 1
        if row[0] == 'FRIDAY':
            friday_count += 1
        if row[0] == 'SATURDAY':
            saturday_count += 1
        if row[0] == 'SUNDAY':
            sunday_count += 1

print("Monday:", monday_count)
print("Tuesday:", tuesday_count)
print("Wednesday:", wednesday_count)
print("Thursday:", thursday_count)
print("Friday:", friday_count)
print("Saturday:", saturday_count)
print("Sunday:", sunday_count)

x = "Monday"
y = monday_count
plt.plot(x,y)

x = "Tuesday"
y = tuesday_count
plt.plot(x,y)

x = "Wednesday"
y = wednesday_count
plt.plot(x,y)

x = "Thursday"
y = thursday_count
plt.plot(x,y)

x = "Friday"
y = friday_count
plt.plot(x,y)

x = "Saturday"
y = saturday_count
plt.plot(x,y)

x = "Sunday"
y = sunday_count
plt.plot(x,y)

plt.gcf().autofmt_xdate()
plt.show()