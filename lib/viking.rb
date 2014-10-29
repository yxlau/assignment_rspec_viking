require_relative 'weapons/axe'
require_relative 'weapons/bow'
require_relative 'weapons/fists'

class Viking
  attr_reader :health, :strength, :name, :weapon

  def initialize(name="RandomViking", health = 100, strength = 10, weapon = nil)
    @name = name
    @health = health
    @strength = strength
    @fists = Fists.new
    @weapon = weapon
  end


  def attack(target)
    puts "#{name} is attacking #{target.name}!"
    target.receive_attack(damage_dealt)
  end

  def receive_attack(damage_dealt)
    take_damage(damage_dealt)
    puts "#{name} took #{damage_dealt} damage and has #{health} health..."
  end

  def pick_up_weapon(weapon)
    raise "Can't pick up that thing" unless weapon.is_a?(Weapon)
    @weapon = weapon
  end

  def drop_weapon
    @weapon = nil
  end

  private
  def damage_dealt
    if @weapon
      damage_with_weapon
    else
      damage_with_fists
    end
  end

  def damage_with_weapon
    begin
      @weapon.use * @strength
    rescue Exception => e
      puts "You could not use your weapon because #{e.message}"
      damage_with_fists
    end
  end

  def damage_with_fists
    @fists.use * @strength
  end

  def take_damage(damage)
    @health -= damage
    check_death
    @health
  end

  def check_death
    raise "#{self.name} has Died..." if @health <= 0
  end

end

# Run script
oleg = Viking.new("Oleg")
sven = Viking.new("Sven")
oleg.attack(sven)
oleg.pick_up_weapon(Bow.new(2))
3.times { oleg.attack(sven) }
sven.attack(oleg)
sven.pick_up_weapon(Axe.new)
3.times {sven.attack(oleg)}
puts "\nInspecting vikings:\n"
puts oleg.inspect
puts sven.inspect
puts "\n...thanks for playing.\n\n"

# Test that:
# Viking:
# Passing a name to a new viking sets that name
# Passing a health attribute to a new viking sets that health attribute
# Health cannot be overwritten after it's been set on initialize
# Weapon starts out `nil` by default

# Bow:
# A Bow's arrow count is readable
# Using a Bow reduces arrows
# Using a Bow with 0 arrows throws an error

# Viking:
# Picking up a weapon sets it as the Viking's weapon
# Picking up a non-weapon raises an exception
# Picking up a new weapon replaces the existing weapon
# Dropping a weapon leaves the Viking weaponless
# The `receive_attack` method reduces that Viking's health by the specified amount
# The `receive_attack` method calls the `take_damage` method (mock!)
# Attacking another viking causes that viking's health to drop
# Attacking another viking calls that viking's `take_damage` method (mock!)
# Attacking with no weapon runs `damage_with_fists` (mock!)
# Attacking with no weapon deals Fists multiplier * strength damage
# Attacking with a weapon runs damage_with_weapon (mock!)
# Attacking with a weapon deals strength * that weapon's multiplier damage
# Attacking with a bow without enough arrows uses fists instead (mock!)
# Killing a viking throws an error 

