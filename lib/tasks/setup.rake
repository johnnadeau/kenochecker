namespace :setup do
  desc "loads games from the past week for when the site is deployed"
  task load_games: :environment do
    ((Date.today - 7)..Date.today).each do |date|
      puts "Loading games for #{date}..."
      Game.load_for_date(date)
    end
  end
end
