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