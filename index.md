# NHL Game Data Analysis


## Setup ##

'''
  library(tidyverse)
  library(lubridate)
    
  nhl <- read_csv("game.csv")
  teams <- read_csv("team_info.csv")
  
  'extract year'
  nhl = mutate(nhl,year2= format(date_time_GMT, format="%Y"))
  
  'remove duplicates' 
  nhlnew = nhl %>% 
    group_by(game_id) %>% 
    filter(row_number()==1) %>% 
    ungroup()
    
'''

## Part One - Basic Analysis

### Most Common Time zone:
'''r
  nhlnew %>% 
    count(venue_time_zone_tz)
'''
It’s no surprise that 54% of NHL games take place in the eastern time zone considering that 16/31 NHL teams reside in the eastern time zone. Another interesting observation from this count is that while most games were recorded using time zones in either EDT/CDT/MDT/PDT, hockey traditionally takes place during the winter months which would use EST/CST/MST/PST. 

### Over the past 20 years, on average, how may goals do the home/away teams score?
'''md
mean(nhlnew$away_goals)
'''

The data here is legitimate because hockey is not a very high scoring game and I know as a spectator it is unlikely to see a team score more than three goals. Analyzing this data fueled my next question around if there was a correlation between the home team scoring more and winning. 

### Are Home or Away Teams More Likely to Win in the Regular Season or Playoffs Respectfully? ##

Based on my analysis of the previous question, I was inspired to see if home teams won more games since they scored more often. Here are my findings:

### Regular season: ###

Disregarding the “tbc win tbc” results, home teams (55%) have a 10% advantage over away teams (45%). Perhaps this can be attributed to having the crowd on your side or not having to deal with travel. 

### Playoff Games: ###

Disregarding the “tbc win tbc” results, home teams (52%) have approximately a 4% advantage over away teams (48%) during playoff games. Perhaps one explanation for this is that the teams in the playoffs are more competitive and less intimidated by the crowd. 

 

## Part Two – Advanced Analysis ##

### Number of Goals Needed by Away Teams to Win During the Regular Season ###

Based on my findings from part one, I was inspired to delve deeper and discover, on average, how many goals away teams needed to score to win regular season and playoff games. According to the histogram, away teams need to score around four goals or to double how many they would typically score to win. Another interesting this graph reveals are that this number has slowly increased starting in 2016 as a new wave of high-scoring NHL superstars, such as Connor McDavid, entered into the league. 

### Number of Goals Needed by Away Teams to Win During the Playoffs ###

Next, I decided to look to see if this number differed in the playoffs suspecting since the competition level is higher. My exploration of playoff data since 2011 fell in line with my hypothesis as teams only need to score closer to three goals to win games during the playoffs. However, a histogram showed that there was not the same positive trend as there was in the regular season chart. 

### Hardest Place to Win ###

By examining the Number of away goals scored in each arena by opposing teams during the regular season, I was able to determine that, in 2019, it was hardest for teams to win against the Boston Bruins. This would make sense because TD Garden, which is where the Bruins play, is a historic venue known for its ruthless crowd. Additionally, the Bruins were the runner-up in the Stanley Cup Championship.

### Atlanta to Winnipeg…a Justified Move? ###

Back in 2011, the Atlanta Thrashers moved to Winnipeg and become the Winnipeg Jets. One of the main reasons for their move was due to Atlanta’s scarce fanbase. As I learned earlier in my analysis, having home ice and a crowd behind a team can influence the game outcome. Atlanta moved to Winnipeg to increase their winning percentage, but I wanted to know if they were able to do so. The data shows that there were but only by about 4% which is not a lot of hockey games. 

### Should the NHL Change the Number of Players Playing at One Time? (Overtime Game Count) ###

Although hockey is played with 12 players (five players and one goaltender per side) at a time, the NHL has entertained the idea of reducing the number of players to reduce the number of overtime games. Reducing the number of players on the ice at one time to four would stimulate more scoring chances. Based on the chart, the NHL might want to consider this proposal as overtime games are at some of their highest levels since 2013. The reason why there are so many (300) OT games is because the data consists of all 82 games for 31 teams, resulting in about 2500+ games per year. 
