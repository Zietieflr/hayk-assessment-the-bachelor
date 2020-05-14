require 'pry'; 



def find_correct_season (data, season_query)
  data.filter { |season, contestant| 
    season === season_query; 
  }
end  

def collect_contestants (received_data)
  contestants_by_season = received_data.map { |season, contestants| 
    contestants.map { |contestant| 
      contestant["season"] = season;
      contestant; 
    }
  }
  contestants_by_season.reduce([]) { |collect, contestant|
    collect.concat contestant
  }
end 

def winner_info (data, season)
  find_correct_season(data, season)[season].find { |contestant| 
    contestant["status"] === "Winner"; 
  }  
end 

def get_first_name_of_season_winner(data, season)
  name = winner_info(data, season)["name"];
  (name.split).first;   
end

def get_contestant_name(data, occupation)
  contestant = collect_contestants(data).find { |contestant|
    contestant["occupation"] === occupation;
  }
  contestant["name"];
end

def count_contestants_by_hometown(data, hometown)
  collect_contestants(data).reduce(0) { |count, contestant|
    contestant["hometown"] === hometown ? count += 1 : count += 0
  }
end

def get_occupation(data, hometown)
  contestant_info = collect_contestants(data).find { |contestant|
    contestant["hometown"] === hometown;
  }
  contestant_info["occupation"];
end

def get_average_age_for_season(data, season)
    contestant_total_age = find_correct_season(data, season)[season].reduce(0) {|sum_of_age, contestant| 
      sum_of_age + contestant["age"].to_i 
    }
  (contestant_total_age/data[season].length.to_f).round
  #For my own understanding => .to_f converts to float, which stores the 19/25 lost from Integers, then rounds
end