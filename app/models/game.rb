class Game < ActiveRecord::Base
  NUMBER_COUNT = 20
  VALID_NUMBERS = 1..80
  VALID_BONUS_MULTIPLIERS = [1, 3, 4, 5, 10]

  serialize :numbers, Array

  has_many :tickets, through: :results
  has_many :results

  validates :game_number, presence: true
  validates :game_date, presence: true
  validates :numbers, length: { is: NUMBER_COUNT }, unique_array: true,
    inclusive_array: { range: VALID_NUMBERS }
  validates :bonus, inclusion: { in: VALID_BONUS_MULTIPLIERS }

  def self.find_by_game_number(game_number)
    game = super game_number
    if !game
      puts 'we need to grab this from the api'
      raw = 
        HTTParty.get('http://www.masslottery.com/data/json/search/dailygames/todays/keno.json', format: :json)
      raw_game = raw['draws'].select { |d| d['draw_id'] == game_number.to_s }.first
      if raw_game
        #{"draw_id"=>"1681255", "jackpot"=>"$37", "winning_num"=>"10-12-17-23-26-32-35-37-39-47-48-49-52-53-55-64-66-74-75-77", "bonus"=>"4x"}
        puts "raw game: #{raw_game}"
        game = self.create(game_number: game_number,
                           numbers: raw_game['winning_num'].split('-').map(&:to_i),
                           bonus: raw_game['bonus'] == 'No Bonus' ? 1 : raw_game['bonus'].chomp('x').to_i,
                           game_date: Date.parse(raw['date']))
      end
    end
    game
  end
end
