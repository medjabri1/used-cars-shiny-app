# Loading libraries 

library(dplyr)

# Loading data from rds file data/my_data.rds

used_cars_data <- readRDS("./data/my_data.rds")

# Calculate overview parameteres

cars_count <- n_distinct(used_cars_data)

manufacturers_count <- n_distinct(select(used_cars_data, manufacturer))

states_count <- n_distinct(select(used_cars_data, state))

cars_types_count <- n_distinct(select(used_cars_data, type))

total_odometer <- paste(sum(select(used_cars_data, odometer)), "KM")

price_range <- paste(min(select(used_cars_data, price)), "-", max(select(used_cars_data, price)), "$")

# Prediction input parameters

region_list <- used_cars_data %>% count(region) %>% select(region)

year_list <- used_cars_data %>% count(year) %>% select(year)

manufacturers_list <- used_cars_data %>% count(manufacturer) %>% select(manufacturer)

condition_list <- used_cars_data %>% count(condition) %>% select(condition)

types_list <- used_cars_data %>% count(type) %>% select(type)

status_list <- used_cars_data %>% count(title_status) %>% select(title_status)

cylinders_list <- used_cars_data %>% count(cylinders) %>% select(cylinders)

fuel_list <- used_cars_data %>% count(fuel) %>% select(fuel)

transmission_list <- used_cars_data %>% count(transmission) %>% select(transmission)

size_list <- used_cars_data %>% count(size) %>% select(size)

drive_list <- used_cars_data %>% count(drive) %>% select(drive)

paint_list <- used_cars_data %>% count(paint_color) %>% select(paint_color)

states_list <- used_cars_data %>% count(state) %>% select(state)

