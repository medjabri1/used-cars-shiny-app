
# Loading libraries

library(dplyr)
library(Amelia)
library(psych)

# Loading Data from csv

used_cars_data <- read.csv("./Dataset/vehicles.csv")

# Cleaning Dataset columns / Remove unecesarry columns

# Columns removed : id, url, county, description, image_url, region_url, VIN, lat, long, posting_data

used_cars_data <- used_cars_data %>%
  select(-id, -url, -model, -county, -description, -image_url, -region_url, -VIN, -lat, -long, -posting_date)

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

# Save data into r data format to reduce time load and not repeat all functions all over again
saveRDS(used_cars_data, "./data/my_data.rds")

# View(used_cars_data)