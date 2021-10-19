class Player
  attr_accessor :name, :life_points
  def initialize(name)
    @name = name
    @life_points = 10
  end

  # indique le nombre de point de vie
  def show_state
    puts "#{@name} a #{@life_points} de PV"
  end

  # Vérification de si un joueur meure
  def gets_damage(point)
    @life_points -= point
    if @life_points <= 0
      puts "Joueur #{@name} est mort !"
    end
  end

  # Attack
  def attacks(player)
    puts "Joueur #{@name} attaque joueur #{player.name}"
    damage = compute_damage
    player.gets_damage(damage)
    puts "Il inflige #{damage} points de dégâts"
  end

  def compute_damage
    return rand(1..6)
  end
end


class HumanPlayer < Player
  attr_accessor :weapon_level
  def initialize(name)
    super(name)
    @weapon_level = 1
    @life_points = 100
  end
  def show_state
    puts "Joueur #{@name} a #{@life_points} de PV et une arme de niveau #{@weapon_level}"
  end

  def compute_damage
    rand(1..6) * @weapon_level
  end

  def search_weapon
    key = rand(1..6)
    puts "Vous avez trouvé une arme de niveau #{key}"
    if @weapon_level < key
      puts "C'est une meilleure arme: vous la prenez"
      @weapon_level = key
    else
      puts "C'est de la merde"
    end
  end

  def search_health_pack
    key = rand(1..6)
    case key
    when (2..5)
      puts "Pack de soin: +50PV"
      @life_points +=50
    when 6
      puts "Pack de Soin+: +80PV"
      @life_points +=80
    else
      puts "Y a rien"
    end
  end
end
