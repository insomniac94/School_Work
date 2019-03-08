import matplotlib.pyplot as plt
import csv

# Signifies the two files to be processed for male and female suicides
file_female = r"C:\Users\walke\Desktop\female_suicide.csv"
file_male = r"C:\Users\walke\Desktop\male_suicide.csv"

# Will store the count deaths in a certain year
female_list = []
male_list = []

# Will store the total number of suicides for males/females
total_f_list = []
total_m_list = []

# List that stores the years for the given data set
years = ['2006','2007','2008','2009','2010','2011','2012','2013','2014','2015','2016']

# Loop to read each row of the csv file and store the result in f_20**,
# where the star will be replaced with the year
with open(file_female) as csvfile:
    readCSV = csv.reader(csvfile, delimiter=',')
    for row in readCSV:
        if row[0] == "2006":
            female_list.append(row[2])
            f_2006 = sum(int(i) for i in female_list)

        if row[0] == "2007":
            female_list.append(row[2])
            f_2007 = sum(int(i) for i in female_list) - f_2006
            
        if row[0] == "2008":
            female_list.append(row[2])
            f_2008 = sum(int(i) for i in female_list) - f_2007 - f_2006

        if row[0] == "2009":
            female_list.append(row[2])
            f_2009 = sum(int(i) for i in female_list) - f_2008 - f_2007 - f_2006

        if row[0] == "2010":
            female_list.append(row[2])
            f_2010 = sum(int(i) for i in female_list) - f_2009 - f_2008 - f_2007 - f_2006

        if row[0] == "2011":
            female_list.append(row[2])
            f_2011 = sum(int(i) for i in female_list) - f_2010 - f_2009 - f_2008 - f_2007 - f_2006

        if row[0] == "2012":
            female_list.append(row[2])
            f_2012 = sum(int(i) for i in female_list) - f_2011 - f_2010 - f_2009 - f_2008 - f_2007 - f_2006

        if row[0] == "2013":
            female_list.append(row[2])
            f_2013 = sum(int(i) for i in female_list) - f_2012 - f_2011 - f_2010 - f_2009 - f_2008 - f_2007 - f_2006

        if row[0] == "2014":
            female_list.append(row[2])
            f_2014 = sum(int(i) for i in female_list) - f_2013 - f_2012 - f_2011 - f_2010 - f_2009 - f_2008 - f_2007 - f_2006

        if row[0] == "2015":
            female_list.append(row[2])
            f_2015 = sum(int(i) for i in female_list) - f_2014 - f_2013 - f_2012 - f_2011 - f_2010 - f_2009 - f_2008 - f_2007 - f_2006

        if row[0] == "2016":
            female_list.append(row[2])
            f_2016 = sum(int(i) for i in female_list) - f_2015 - f_2014 - f_2013 - f_2012 - f_2011 - f_2010 - f_2009 - f_2008 - f_2007 - f_2006

# Loop to read each row of the csv file and store the result in m_20**,
# where the star will be replaced with the year       
with open(file_male) as csvfile:
    readCSV = csv.reader(csvfile, delimiter=',')
    for row in readCSV:
        if row[0] == "2006":
            male_list.append(row[2])
            m_2006 = sum(int(i) for i in male_list)

        if row[0] == "2007":
            male_list.append(row[2])
            m_2007 = sum(int(i) for i in male_list) - f_2006

        if row[0] == "2008":
            male_list.append(row[2])
            m_2008 = sum(int(i) for i in male_list) - f_2006 - f_2007

        if row[0] == "2009":
            male_list.append(row[2])
            m_2009 = sum(int(i) for i in male_list) - f_2008 - f_2007 - f_2006

        if row[0] == "2010":
            male_list.append(row[2])
            m_2010 = sum(int(i) for i in male_list) - f_2009 - f_2008 - f_2007 - f_2006

        if row[0] == "2011":
            male_list.append(row[2])
            m_2011 = sum(int(i) for i in male_list) - f_2010 - f_2009 - f_2008 - f_2007 - f_2006

        if row[0] == "2012":
            male_list.append(row[2])
            m_2012 = sum(int(i) for i in male_list) - f_2011 - f_2010 - f_2009 - f_2008 - f_2007 - f_2006

        if row[0] == "2013":
            male_list.append(row[2])
            m_2013 = sum(int(i) for i in male_list)  - f_2012 - f_2011 - f_2010 - f_2009 - f_2008 - f_2007 - f_2006

        if row[0] == "2014":
            male_list.append(row[2])
            m_2014 = sum(int(i) for i in male_list)- f_2013 - f_2012 - f_2011 - f_2010 - f_2009 - f_2008 - f_2007 - f_2006

        if row[0] == "2015":
            male_list.append(row[2])
            m_2015 = sum(int(i) for i in male_list) - f_2014 - f_2013 - f_2012 - f_2011 - f_2010 - f_2009 - f_2008 - f_2007 - f_2006

        if row[0] == "2016":
            male_list.append(row[2])
            m_2016 = sum(int(i) for i in male_list) - f_2015 - f_2014 - f_2013 - f_2012 - f_2011 - f_2010 - f_2009 - f_2008 - f_2007 - f_2006

# Appends the total number of male suicides
# for each of the ten years to the total male list
total_m_list.append(m_2006)
total_m_list.append(m_2007)
total_m_list.append(m_2008)
total_m_list.append(m_2009)
total_m_list.append(m_2010)
total_m_list.append(m_2011)
total_m_list.append(m_2012)
total_m_list.append(m_2013)
total_m_list.append(m_2014)
total_m_list.append(m_2015)
total_m_list.append(m_2016)

# Appends the total number of female suicides
# for each of the ten years to the total female list
total_f_list.append(f_2006)
total_f_list.append(f_2007)
total_f_list.append(f_2008)
total_f_list.append(f_2009)
total_f_list.append(f_2010)
total_f_list.append(f_2011)
total_f_list.append(f_2012)
total_f_list.append(f_2013)
total_f_list.append(f_2014)
total_f_list.append(f_2015)
total_f_list.append(f_2016)

# Plots the points for female sucides for the 10 year data
# set with a pink line
plt.plot(years,total_f_list,color='pink')

# Plots the points for male sucides for the 10 year data
# set with the blue line
plt.plot(years,total_m_list,color='blue')

# Sets the labels and title for the table
plt.xlabel('Years')
plt.ylabel('Deaths')
plt.title('The Number of Suicides Over 10 Years')
plt.show()

