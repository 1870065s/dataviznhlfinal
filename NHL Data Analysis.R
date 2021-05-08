  library(tidyverse)
  library(lubridate)
  
  'Setup'
  
  nhl <- read_csv("game.csv")
  teams <- read_csv("team_info.csv")
  
  'extract year'
  nhl = mutate(nhl,year2= format(date_time_GMT, format="%Y"))
  
  'remove duplicates' 
  nhlnew = nhl %>% 
    group_by(game_id) %>% 
    filter(row_number()==1) %>% 
    ungroup()
  
  '**NOTES**
  - Data only contains playoff data from 2011 onwards, so most analyses have been adapted
  - Around 3000 games were dupicted in the original dataset, so I included code to remove them(above)'
  
  ------------------------------------------------------------------------------
  'Type 1 Questions (using simple functions)'
  
  'In which time zone do most games take place?'
  
  nhlnew %>% 
    count(venue_time_zone_tz)
  
  'Over the past 20 years, on average, how many goals to away teams score?'
  mean(nhlnew$away_goals)
  
  'Over the past 20 years, on average, how many goals to home teams score?'
  mean(nhlnew$home_goals)
  
  'Regular Season Outcomes'
  nhlnew %>% 
    filter(type=="R") %>% 
    count(outcome)
  
  'Playoff Outcomes'
  nhlnew %>% 
    filter(type=="P") %>% 
    count(outcome)
  
 -------------------------------------------------------------------------------

  'Average Number of goals needed by away teams to attain regular season win by year'
  nhlnew %>% 
    filter(year2 >2011) %>% 
    filter(type == "R") %>% 
    filter(outcome =="away win REG"|outcome =="away win OT") %>%
    group_by(year2) %>%  
    summarize(arw = mean(away_goals)) %>% 
    ggplot(aes(year2,arw,fill=arw))+
    geom_bar(stat = "identity")+
    xlab("Year")+
    ylab("Goals")+
    guides(fill = FALSE)

  'Average number of goals are needed to win by away teams in the playoffs by year'

   nhlnew %>% 
      filter(year2 >2011) %>% 
      filter(type == "P") %>% 
      filter(outcome =="away win REG"|outcome =="away win OT") %>%
      group_by(year2) %>%  
      summarize(apw = mean(away_goals)) %>% 
      ggplot(aes(year2,apw,fill = apw))+
      geom_bar(stat = "identity")+
      xlab("Year")+
      ylab("Goals")+
      guides(fill = FALSE)
    
   'Where is it hardest for away teams to win during the regular season?'

   nhlv = nhl %>% 
          select(year2,type,away_goals,home_goals,outcome,venue)
   
     nhlv %>% 
      filter(year2 == "2019") %>% 
      filter(outcome == "away win OT"|outcome == "away win reg") %>% 
      filter(type == "R") %>% 
      group_by(venue) %>% 
      summarise(aag = sum(away_goals,na.rm=TRUE)) %>%
                  ggplot(aes(reorder(venue,aag),aag,fill = venue))+
                  geom_bar(stat = "identity")+
                  coord_flip()+
                  xlab("Arena")+
                  ylab("Away Win Goal Sum")+
                  guides(fill = FALSE)
                            
                  
  'Top 5 teams who win most at home/away during the playoffs?'

    homeplayoffwin = nhl %>% 
      filter(type == "P") %>% 
      filter(outcome == "home win REG"| outcome == "home win OT") %>% 
      count(home_team_id) %>% 
      arrange(desc(n))
      print(homeplayoffwin)
    
   awayplayoffwin =  nhl %>% 
      filter(type == "P") %>% 
      filter(outcome == "away win REG"| outcome == "away win OT") %>% 
      count(home_team_id) %>% 
      arrange(desc(n))
   
    hpwn=homeplayoffwin %>% 
      full_join(teams,by = c("home_team_id"="team_id")) %>% 
      select(abbreviation,n)
    
    apwn=awayplayoffwin %>% 
      full_join(teams,by = c("home_team_id"="team_id")) %>% 
      select(abbreviation,n)
   
    
    print(top_n(hpwn,5))
    print(top_n(apwn,5))
  
  
  
  'Has moving from Atlanta to Winnipeg increased their home winning percentage?'

   atlwin = nhl %>% 
      filter(home_team_id == "3") %>%
      filter(outcome == "home win REG"| outcome == "home win OT") %>% 
      count(outcome)
     
      
    wpgwin=  nhl %>% 
      filter(home_team_id == "52") %>% 
      filter(outcome == "home win REG"| outcome == "home win OT") %>% 
      count(outcome)
    
    print(atlwin)
    print(wpgwin)
    
     
  'Total number of goals scored by year'
    
    nhlnew %>%
      filter(year2 >=2011 & year2 <= 2019) %>% 
      filter(type == "R" | type == "P") %>% 
      group_by(year2,type) %>%
      summarise(totgoals = sum(away_goals+home_goals)) %>% 
      ggplot(aes(year2,totgoals,fill=type))+
      geom_bar(stat = "identity")+
      xlab("Year")+
      ylab("Total Goals Scored")
      
     
  'Number of overtime games - do rules need to change (to 4 v 4)?' 

   nhlnew %>% 
     filter(year2 < 2019) %>% 
     filter(outcome == "away win OT" | outcome == "home win OT") %>% 
     count(year2) %>% 
     ggplot(aes(year2,n,group = 1))+
     geom_line()+
     xlab("Year")+
     ylab("OT Games")
   
     

  --
    
   'Extra. Please Ignore'
   nhl %>% 
      count(game_id) %>% 
      filter(n>2)
    
    nhl %>% 
      filter(game_id == 2018020001)
   
    
    
  
    


    
    
    
    
    
    
 
  