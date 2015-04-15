class Game < ActiveRecord::Base
  NUMBER_COUNT = 20
  VALID_NUMBERS = 1..80
  VALID_BONUS_MULTIPLIERS = [1, 3, 4, 5, 10]

  serialize :numbers, Array

  has_many :tickets, through: :results
  has_many :results

  validates :game_number, presence: true
  validates :game_date, presence: true
  validates :numbers, length: { is: NUMBER_COUNT },
    unique_array: true,
    inclusive_array: { range: VALID_NUMBERS }
  validates :bonus, inclusion: { in: VALID_BONUS_MULTIPLIERS }

  def self.find_by_game_number(game_number)
    find_by_game_number_and_game_date(game_number, nil)
  end

  def self.find_by_game_number_and_game_date(game_number, game_date)
    game = self.find_by(game_number: game_number)
    unless game
      raw =HTTParty.get(api_url(game_date), format: :json)
      raw_game = raw['draws'].select { |d| d['draw_id'] == game_number.to_s }.first
      if raw_game
        game = create_from_json(raw_game)
      end
    end
    game
  end

  private

  def self.bonus_value(raw)
    'No Bonus' ? 1 : raw.chomp('x').to_i
  end

  def self.create_from_json(json)
    create!(game_number: json['draw_id'],
            numbers: json['winning_num'].split('-').map(&:to_i),
            bonus: bonus_value(json['bonus']),
            game_date: game_date(json))
  end

  def self.game_date(json)
    if json.has_key? 'draw_date'
      Date.strptime(json['draw_date'], '%m/%d/%Y')
    else
      Date.today
    end
  end

  def self.api_url(date = nil)
    if date
      "http://www.masslottery.com/data/json/search/dailygames/history/keno/#{date.strftime("%Y%m")}.json"
    else
      'http://www.masslottery.com/data/json/search/dailygames/todays/keno.json'
    end
  end
end
