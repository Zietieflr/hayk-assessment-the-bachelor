require 'pry'; 

#Helper Method => Returns the season array after given the entire data structure and season. 
def find_correct_season (data, season)
  data.select { |data| 
  data.to_s === season; 
}
end 

def collect_contestants (data)
  all_contestants = []; 
  data.map { |season, contestants| 
    contestants.map { |contestant| 
      contestant["season"] = season;
      all_contestants << contestant; 
    }
  }
  all_contestants; 
end 

def winner_info (data, season)
  season_array = find_correct_season(data, season); 
  season_array[season].select { |contestant| 
    contestant["status"] === "Winner"; 
  } 
end 

def get_first_name_of_season_winner(data, season)
  name = winner_info(data, season)[0]["name"]; 
  name.split[0]; 
end

def get_contestant_name(data, occupation)
  contestant = collect_contestants(data).select { |contestant|
    contestant["occupation"] === occupation;
  }
  contestant[0]["name"];
end

# def count_contestants_by_hometown(data, hometown)
#   trial = collect_contestants(data).reduce(0) {|count, contestant|
#   #binding.pry; 
#     if contestant["hometown"] === hometown
#       #count += 1; 
#       binding.pry;
#     end 
#   }
#   binding.pry; 
#   trial; 
# end

def count_contestants_by_hometown(data, hometown)
  count = 0; 
  collect_contestants(data).map {|contestant|
  #binding.pry; 
    if contestant["hometown"] === hometown
      count += 1; 
    end 
  }
  count; 
end

def get_occupation(data, hometown)
  contestant = collect_contestants(data).select { |contestant|
    contestant["hometown"] === hometown;
  }
  contestant[0]["occupation"];
end

# def get_average_age_for_season(data, season)
#   ages = find_correct_season(data, season)[season].reduce([age: 0, count: 0]) {|memo, contestant|
#     binding.pry; 
#     memo[0][:age] += contestant["age"].to_i;
#     memo[0][:count] += 0;
  
#     binding.pry; 
#   }
# ages
# binding.pry; 
# end

def get_average_age_for_season(data, season)
  contest_age = {age: 0, count: 0};
  find_correct_season(data, season)[season].map {|contestant| 
    contest_age[:age] += contestant["age"].to_i;
    contest_age[:count] += 1;
  }
(contest_age[:age]/contest_age[:count].to_f).round(); 
#For my own understanding => .to_f converts to float, which stores the 19/25 lost from Integers, then rounds
end