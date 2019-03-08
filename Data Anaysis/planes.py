import csv

# List to store names of the top 5 planes
top_ten_planes = ["de Havilland Canada DHC-6 Twin Otter 300","Douglas C-47A","Douglas C-47","Antonov An-26","Douglas DC-4"]

# Counter the number of crashes for each of the top 5 planes
top_ten_planes_count_1 = 0
top_ten_planes_count_2 = 0
top_ten_planes_count_3 = 0
top_ten_planes_count_4 = 0
top_ten_planes_count_5 = 0

# Signifies the file to be processed
file = r"C:\Users\walke\Desktop\planecrashinfo_20181121001952.csv"

# Loop to read each row of the csv file and increments
# the count for each plane crash count when found in csv file
with open(file) as csvfile:
    readCSV = csv.reader(csvfile, delimiter=',')
    for row in readCSV:
        if row[0] == top_ten_planes[0]:
            top_ten_planes_count_1 += 1
        if row[0] == top_ten_planes[1]:
            top_ten_planes_count_2 += 1
        if row[0] == top_ten_planes[2]:
            top_ten_planes_count_3 += 1
        if row[0] == top_ten_planes[3]:
            top_ten_planes_count_4 += 1
        if row[0] == top_ten_planes[4]:
            top_ten_planes_count_5 += 1

# Print statements to display the data results of the top 5 planes in a table
print("")
print("------------------------------------------------------------------")
print("|                  Top 5 Plane Crashes and Counts                |")
print("|----------------------------------------------------------------|")
print("|  Plane Name                               | Number of Crashes  |")
print("| ---------------------------------------------------------------|")

print("|",top_ten_planes[0], " |", top_ten_planes_count_1, "                |")
print("|----------------------------------------------------------------|")

print("|",top_ten_planes[1],"                            |", top_ten_planes_count_2, "                |")
print("|----------------------------------------------------------------|")

print("|",top_ten_planes[2],"                             |", top_ten_planes_count_3, "                |")
print("|----------------------------------------------------------------|")

print("|",top_ten_planes[3],"                            |", top_ten_planes_count_4, "                 |")
print("|----------------------------------------------------------------|")

print("|",top_ten_planes[4],"                             |", top_ten_planes_count_5, "                |")
print("|----------------------------------------------------------------|")