library(DBI)
library(RSQLite)
drv <- dbDriver('SQLite')
con <- dbConnect(drv, dbname="baseball.db")
dbListTables(con)
team.df <- dbGetQuery(con, 
                      paste("SELECT yearID, teamID, G, W, name, SUM(salary)",
                            "AS payroll FROM Salaries",
                            "INNER JOIN Teams USING(yearID, teamID)",
                            "WHERE yearID > 1984",
                            "GROUP BY yearID, teamID;"))

dfx <- data.frame(
  group = c(rep('A', 8), rep('B', 15), rep('C', 6)),
  sex = sample(c("M", "F"), size = 29, replace = TRUE),
  age = runif(n = 29, min = 18, max = 54)
)

library(bigrquery)
project <- "nyc-taxi-data-1048"
taxiTimes <- "SELECT DATE(pickup_datetime) AS pickupDay, HOUR(pickup_datetime) AS pickupHour, 
COUNT(*) AS num_pickups FROM [nyc-tlc:yellow.trips_2015] WHERE (pickup_latitude BETWEEN 40.61 AND 40.91)  
AND (pickup_longitude BETWEEN -74.06 AND -73.77) GROUP BY pickupDay, pickupHour ORDER BY pickupDay, pickupHour;"

taxi_df <- query_exec(taxiTimes, project = project, max_pages = Inf)
dim(taxi_df) 
