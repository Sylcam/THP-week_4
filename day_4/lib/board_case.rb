class BoardCase
  attr_accessor :first
  attr_reader :second

  def initialize
  end

  # Premier joeuur
  def self.first
    @first
  end

  def self.first=first_value
    @first = first_value
  end

  # Second joueur
  def self.second
    return (@first == "X") ? "O" : "X"
  end

  def self.empty
    return " "
  end

end
