# Your code here
require 'viking'

describe Viking do
  before do
    allow(STDOUT).to receive(:puts).and_return(nil)
  end
  let(:v){ Viking.new }
  let(:abe){ Viking.new('abe', 90, 10, Bow.new)}
  let(:bow){ Bow.new}
  let(:axe){ Axe.new}

  describe '#initialize' do
    it 'passing a name to new Viking sets the name attribute' do
      expect(abe.name).to eq('abe')
    end
    it 'passing health to new Viking sets the health attritube' do
      expect(abe.health).to eq(90)
    end
    it 'health cannnot be overwritten after it\'s been set on initialize' do
      expect{abe.health = 50}.to raise_error(NoMethodError)
    end
    it 'Viking\'s weapon is nil by default' do
      expect(v.weapon).to be_nil
    end
  end

  describe '#pick_up_weapon(weapon)' do
    it 'picking up weapon sets it as Viking\'s weapon' do
      expect(abe.weapon).to be_a(Bow)
    end
    it 'picking up a non-weapon raises an exception' do
      expect{v.pick_up_weapon(Viking.new)}.to raise_error("Can't pick up that thing")
    end
    it 'picking up a new weapon replaces a Viking\'s existing weapon' do
      v.pick_up_weapon(axe)
      expect(v.weapon).to be_a(Axe)
    end
  end

  describe '#drop_weapon' do
    it 'dropping a Viking\'s weapon leaves the Viking weaponless' do
      abe.drop_weapon
      expect(abe.weapon).to be_nil
    end
  end

  describe '#receive_attack' do
    it 'reduces Viking\'s health by the specified amount' do
      v.receive_attack(45)
      expect(v.health).to eq(55)
    end
    it 'calls the take_damage method' do
      expect(v).to receive(:take_damage).with(45)
      v.receive_attack(45)
    end
  end

  describe '#attack' do
    it 'causes recipient\'s health to drop' do
      abe.attack(v)
      expect(v.health).to be < 100
    end
    it 'calls that Viking\'s take_damage method' do
      expect(v).to receive(:take_damage)
      abe.attack(v)
    end
    it 'attacking with no weapon runs damage_with_fists' do
      expect(v).to receive(:damage_with_fists).and_return(2.5)
      v.attack(abe)
    end
    it 'attacking with no weapon deals Fists multiplier times strength damage' do
      expect(abe).to receive(:receive_attack).with(2.5)
      v.attack(abe)
    end
    it 'attacking with a weapon runs damage_with_weapon' do
      expect(abe).to receive(:damage_with_weapon).and_return(11)
      abe.attack(v)
    end
    it 'attacking with a weapon deals damage equal to the Viking\'s strength times that Weapon\'s multiplier' do
      allow(abe.weapon).to receive(:use).and_return(5)
      expect(v).to receive(:receive_attack).with(50)
      abe.attack(v)
    end
    it 'attacking using a bow without enough arrows uses fists instead' do
      b = Bow.new(0)
      v.pick_up_weapon(b)
      expect(v).to receive(:damage_with_fists).and_return(1)
      v.attack(abe)
    end
  end
  describe '#check_death' do
    it 'killing a viking raises an error' do
      expect{ v.check_death}.to raise_error(NoMethodError)
    end
  end

end
