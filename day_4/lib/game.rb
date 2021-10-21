require_relative 'player.rb'
require_relative 'board.rb'
require_relative 'board_case.rb'

class Game
  attr_accessor :current_player,:status,:board, :player1, :player2
  def initialize
    @status= "On going"
  end

  # jeu
  def play
    init_player()
    init_board()
    puts "Lancement du jeu"
  end

  # Lancement du jeu
  def init_player
    puts "      Jeu du Morpion       "
    puts "|************************|"

    # démarrage
    puts ""
    puts "Entré les noms des joueurs: "
    print ">Joueur 1: "
    name1 = gets.chomp.strip
    print ">Son signe (X ou O): "
    token1= gets.chomp.strip.upcase

    while token1 != "X" && token1 != "O"
      puts "Le signe doit être X ou O, recommence."
      print ">Son signe (X ou O): "
      token1= gets.chomp.strip.upcase
    end

    print ">Joueur 2: "
    name2 = gets.chomp.strip
    token2 = token1 == "X" ? "O": "X"
    puts "Game: #{name1}(#{token1}) vs #{name2}(#{token2}) "
    @player1 = Player.new(name1,token1)
    BoardCase.first = token1
    @player2 = Player.new(name2, token2)
    @current_player = @player1
  end

  # lancement du plateau
  def init_board
    @board = Board.new
    @board.display_board
  end

  # joueur actuel
  def get_current_player
    @board.count_turn % 2 == 0 ? (@current_player = @player1) : (@current_player  = @player2)
  end

  # chnagement de tour
  def turn
    puts "Tour de #{@board.count_turn + 1}, joueur #{get_current_player.name} chosie:"
    @board.play_turn
  end

  # relancé une game
  def new_round
    init_board()
  end  

  # fin du jeu
  def winner
    if @board.over?
      check = @board.won?
        if check != false
          player = player1.token == check ? player1 : player2
          puts
          puts "GG #{player.name}!"
          puts "|****************|"
          puts "Appyé sur une touche pour continuer ..."
          gets.chomp
        else
          puts "Fin du jeu, aucun gagnant"
        end
     end
  end

  # vérif fin du jeu
  def is_end_game?
    @status= "End"
    return @board.over?
  end

  # fin du jeu, sans round 2
  def end_game
    puts "Merci, Aur revoir"
  end
end
