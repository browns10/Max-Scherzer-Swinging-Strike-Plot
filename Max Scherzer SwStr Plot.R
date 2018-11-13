#Using statcast data from 2018 visualize the swinging strikes from May 6th 2018
#Max Scherzer's 15 strikeout game vs PHI 

S <- scrape_statcast_savant(start_date = "2018-05-06", end_date = "2018-05-06", playerid = 453286, player_type = 'pitcher')

Scherzer_Data <-rbind(S) 

#Use SQL to filter the data to swinging strikes
Scherzer_Data <- sqldf("select *
                       from Scherzer_Data
                       where description = 'swinging_strike'")

#View the data to ensure it is what we want
View(Scherzer_Data)

#Create strike zone based on MLB averages (Source: Analyzing Baseball Data with R)
top_zone <- 3.5
bot_zone <- 1.6
left_zone <- -0.95
right_zone <- 0.95
strike_zone_df <- data.frame(
  x = c(left_zone, left_zone, right_zone, right_zone, left_zone),
  y = c(bot_zone, top_zone, top_zone, bot_zone, bot_zone)
)

#Filter the swinging strikes by unique pitch types from Max Scherzer's 15K game last year
#Split plot by batter hand
#Plot our data 
Scherzer_Data %>%

Scherzer_Plot1 <- ggplot() + 
geom_path(data = strike_zone_df, aes(x = x, y = y)) +
coord_equal() +
xlab("Horizontal Distance (ft)") +
ylab("Vertical Distance (ft)") +
geom_point(data = Scherzer_Data, aes(x = plate_x, y = plate_z, color = pitch_type, size = release_speed)) +
facet_wrap(. ~ stand)

#add title and subtitle to our plot
Scherzer_Plot1 + labs(title = "Max Scherzer Swinging Strike Locations 5/6/18", subtitle = "Catcher's View", caption = "Data courtesy of MLBAM")





  
  

