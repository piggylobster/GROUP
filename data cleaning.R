# environment
library(lubridate)

# load data
cab_rides <- read.csv('cab_rides.csv')
weather <- read.csv('weather.csv')

# data type
## cab rides
cab_rides$cab_type <- as.character(cab_rides$cab_type)
cab_rides$destination <- as.character(cab_rides$destination)
cab_rides$source <- as.character(cab_rides$source)
cab_rides$id <- as.character(cab_rides$id)
cab_rides$product_id <- as.character(cab_rides$product_id)
cab_rides$name <- as.character(cab_rides$name)
cab_rides$time <- ymd_hms(as.POSIXct(cab_rides$time_stamp / 1000, origin = '1970-01-01'), tz = 'EST')

str(cab_rides)

##weather
weather$location <- as.character(weather$location)
weather$time <- ymd_hms(as.POSIXct(weather$time_stamp, origin = '1970-01-01'), tz = 'EST')
names(weather)[2] <- 'source'

str(weather)

# NA omit
## cab rides
cab_rides_omit <- na.omit(cab_rides)
any(is.na(cab_rides_omit))

## weather
weather$rain[is.na(weather$rain)] <- 0
weather_omit <- na.omit(weather)
any(is.na(weather_omit))

# merge
cab_weather <- merge(cab_rides_omit, weather_omit, by = c('time', 'source'))

