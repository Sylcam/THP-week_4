require 'bundler'
Bundler.require

require_relative 'lib/game.rb'
require_relative 'lib/player.rb'

# méthode help
def call_enemies(array)
  list_enemies = []
  array.each do |enem|
    list_enemies.push(Player.new(enem))
  end
  return list_enemies
end


def is_all_died?(enemies)
  return enemies.all?{|e| e.life_points <= 0}
end

def show_state_list(enemies)
  enemies.each_with_index do |e,i|
    if e.life_points >0 
      puts "#{i} - #{e.name} a #{e.life_points} PV"
    end
  end
end
def attack_enemies(player,enemies)
  enemies.each do |e|
    if e.life_points > 0
      player.attacks(e)
    end
  end
end

def enemies_attack(player, enemies)
  enemies.each do |e|
    if player.life_points > 0 && e.life_points >0
        e.attacks(player)
    end
  end
end



# ---------------------------------------------
# Program
puts "----------------------------------------"
puts "|Bienvenuez     !|"
puts "|Dernier survivant gaggne !|"
puts "----------------------------------------"

puts "Quel est ton nom ?"
print ">"
name_player = gets.chomp
player1 = HumanPlayer.new(name_player)
puts "#{name_player}!"
puts "Press une touche pour commencé"
gets.chomp

bots  = call_enemies(["Josiane","José"])



# Boucle t'attaque
while player1.life_points >0 && !is_all_died?(bots)
  
  # prépare la bataille
  puts " "
  puts "--------------------------------------"
  puts "Nouveau round"
  player1.show_state
  puts ""
  puts "Que voulez-vous faire ?"
  puts "a - Chercher arme"
  puts "s - Schercher de la vie"
    
  puts " "
  puts "attaqué joueur "
  show_state_list(bots)

  choice = gets.chomp
  case choice
  when "a"
    player1.search_weapon
  when "s"
    player1.search_health_pack
  when "0".."1" 
    bot  = bots[choice.to_i]
    if bot.life_points > 0
      player1.attacks(bot)
    else
      puts "#{bot.name} est mort, vous pouvez attaqué personne"
    end
  else
    puts "Votre choix entre a et s, recommencé"
    choice = gets.chomp
  end
  gets.chomp

  puts " "
  puts "L'IA vous attaque"
  if  !is_all_died?(bots)
    enemies_attack(player1, bots)
  end
end

puts " "
puts "*"*50
puts player1.life_points > 0 ? 
"Bravo! vous avez gagnez" : 
"Game Over :("
puts "*"*50

# binding.pry
