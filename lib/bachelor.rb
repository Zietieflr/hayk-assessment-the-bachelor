require 'pry'


def find_season(seasons, season_query)
  seasons.select { |season| season == season_query }
end

def collect_contestants(seasons)
  seasons.reduce([]) do |all_contestants, (season, contestants)|
    contestants_with_season = contestants.map do |contestant|
      contestant['season'] = season
      contestant
    end
    all_contestants.concat contestants_with_season
  end
end

def winner_info(seasons, season_query)
  find_season(seasons, season_query)[season_query]
    .find { |contestant| contestant['status'] == 'Winner' }
end

def get_first_name_of_season_winner(seasons, season_query)
  full_name = winner_info(seasons, season_query)['name']
  full_name.split.first
end

def get_contestant_by_key(seasons, key, value)
  collect_contestants(seasons).find { |contestant| contestant[key] == value }
end

def get_contestant_name(seasons, occupation_of_contestant)
  contestant_by_occupation = get_contestant_by_key(seasons, 'occupation', occupation_of_contestant)
  contestant_by_occupation['name']
end

def count_contestants_by_hometown(seasons, hometown)
  # Did not use get_contestant_by_key as it will only return the first result
  # this wants several
  collect_contestants(seasons).reduce(0) { |count, contestant|
    contestant['hometown'] == hometown ? count + 1 : count + 0 }
end

def get_occupation(seasons, hometown_of_contestant)
  contestant_by_hometown = get_contestant_by_key(seasons, 'hometown', hometown_of_contestant)
  contestant_by_hometown['occupation']
end

def get_average_age_for_season(seasons, season)
  contestant_total_age = find_season(data, season)[season].reduce(0) { |sum_of_age, 
    contestant| sum_of_age + contestant['age'].to_i }
  (contestant_total_age/seasons[season].length.to_f).round
  # For my own understanding => .to_f converts to float, which stores the 19/25
  # lost from Integers, then rounds
end
