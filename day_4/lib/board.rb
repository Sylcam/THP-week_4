require_relative 'board_case.rb'
class Board
  attr_accessor :board, :is_won

  def initialize
    empty = BoardCase.empty
    @board = [empty,empty,empty,empty,empty,empty,empty,empty,empty]
    @is_won = false
  end

  #list de victoires
  WIN_COMBINATIONS = [ 
    [0,1,2], # ligne haut 
    [3,4,5], # ligne mid 
    [6,7,8], # ligne bas 
    [0,3,6], # colonne gauche 
    [1,4,7], # colonne centre 
    [2,5,8], # colonne droite 
    [0,4,8], # diagonal 
    [6,4,2] # diagonale 
    ]

  # Affichage
  def display_board
    puts
    puts "Board game: "
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "

  end

  # Coup du joueur
  def move(index,token)
    @board[index] = token
  end

  def position_taken?(index)
    return (@board[index].strip != "")
  end

  def valid_move?(index)
    return (index.between?(0,8) && !position_taken?(index))
  end

  def count_turn
    @board.count{|token| token.strip != ""}
  end

  def current_player_token
    count_turn % 2 == 0 ? BoardCase.first : BoardCase.second
  end

  def play_turn
    puts "Entré un choffre de 1-9"
    input = gets.chomp.strip.to_i-1
    while !(0..8).to_a.include?(input)
      puts "Uniquement des chiffre de 1 à 9, recommencé:"
      input = gets.chomp.strip.to_i-1
    end
    if !valid_move?(input)
      puts "Position déjà occupé, recommencé"
      play_turn
    end
    move(input, current_player_token)
    display_board
  end

  # vérif victoire
  def won?
    WIN_COMBINATIONS.each do |win_case|
      windex_1 = win_case[0]
      windex_2 = win_case[1]
      windex_3 = win_case[2]

      val1 = @board[windex_1]
      val2 = @board[windex_2]
      val3 = @board[windex_3]

      if (val1 == val2 && val2 == val3 && val1.strip != "")
        @is_won = true
        return val1
      end
    end
    @is_won = false
    return false
  end

  def full?
    @board.all?{|token| token.strip != ""}
  end

  # égalité
  def draw?
    won?
    return (!@is_won && full?)
  end

  # fin du jeu
  def over?
    won?
    return (draw? || @is_won)
  end

end
