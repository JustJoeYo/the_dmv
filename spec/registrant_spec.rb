require 'spec_helper'

RSpec.describe Registrant do
  before(:each) do
    @registrant_1 = Registrant.new('Bruce', 18, true)
    @registrant_2 = Registrant.new('Penny', 16)
    @registrant_3 = Registrant.new('Tucker', 15)
  end

  describe '#initialize' do
    it 'can initialize' do
      expect(@registrant_1).to be_an_instance_of(Registrant) #=> true
      expect(@registrant_2).to be_an_instance_of(Registrant) #=> true
      expect(@registrant_3).to be_an_instance_of(Registrant) #=> true
    end
  end

  describe '#name' do
    it 'has a name' do
      expect(@registrant_1.name).to eq('Bruce') #=> "Bruce"
      expect(@registrant_2.name).to eq('Penny') #=> "Penny"
      expect(@registrant_3.name).to eq('Tucker') #=> "Tucker"
    end
  end

  describe '#age' do
    it 'has an age' do
      expect(@registrant_1.age).to eq(18) #=> 18
      expect(@registrant_2.age).to eq(16) #=> 16
      expect(@registrant_3.age).to eq(15) #=> 15
    end
  end

  describe '#permit?' do
    it 'has a permit' do
      expect(@registrant_1.permit?).to be true #=> true
      expect(@registrant_2.permit?).to be false #=> false
      expect(@registrant_3.permit?).to be false #=> false
    end
  end

  describe '#license_data' do
    it 'has license data' do
      expect(@registrant_1.license_data).to eq({ written: false, license: false, renewed: false }) #=> {:written=>false, :license=>false, :renewed=>false}
      expect(@registrant_2.license_data).to eq({ written: false, license: false, renewed: false }) #=> {:written=>false, :license=>false, :renewed=>false}
      expect(@registrant_3.license_data).to eq({ written: false, license: false, renewed: false }) #=> {:written=>false, :license=>false, :renewed=>false}
    end
  end

  describe '#earn_permit' do
    it 'can earn a permit' do
      @registrant_2.earn_permit
      expect(@registrant_2.permit?).to be true #=> true

      @registrant_3.earn_permit
      expect(@registrant_3.permit?).to be true #=> true
    end
  end
end