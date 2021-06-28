
# Loading libraries

library(dplyr)
library(Amelia)
library(psych)

# Loading Data from csv

used_cars_data <- read.csv("./Dataset/vehicles.csv")

# Cleaning Dataset columns / Remove unecesarry columns

# Columns removed : id, url, county, description, image_url, region_url, VIN, model

used_cars_data <- select(used_cars_data, -id, -url, -county, -description, -image_url, -region_url, -VIN, -model)

# Cleaning rows 

# Removing observations with NA values on them

used_cars_data <- na.omit(used_cars_data)

# Removing observations with price lower than 500 and bigger than 400000
# Remove observations with empty values

used_cars_data <- filter(
  used_cars_data, 
  
  price > 499, 
  price < 400000, 
  manufacturer != "", 
  cylinders != "", 
  drive != "",
  size != "",
  paint_color != ""
)

# View(used_cars_data)