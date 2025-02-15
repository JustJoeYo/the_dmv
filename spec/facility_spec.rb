require 'spec_helper'

RSpec.describe Facility do
  before(:each) do
    @facility_1 = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
    @facility_2 = Facility.new({name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600'})
    @cruz = Vehicle.new({ vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice })
    @bolt = Vehicle.new({ vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev })
    @camaro = Vehicle.new({ vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice })
    @registrant_1 = Registrant.new('Bruce', 18, true)
    @registrant_2 = Registrant.new('Penny', 16)
    @registrant_3 = Registrant.new('Tucker', 15)
  end

  describe '#add service' do
    it 'can add available services' do
      expect(@facility_1.services).to eq([]) #=> []
      @facility_1.add_service('New Drivers License')
      @facility_1.add_service('Renew License')
      @facility_1.add_service('Vehicle Registration')
      expect(@facility_1.services).to eq(['New Drivers License', 'Renew License', 'Vehicle Registration']) #=> ["New Drivers License", "Renew License", "Vehicle Registration"]
    end
  end

  describe '#administer_road_test' do
    it 'can administer road tests' do
      @facility_1.add_service('Written Test')
      @facility_1.add_service('Road Test')

      expect(@facility_1.administer_road_test(@registrant_3)).to be false #=> false
      @registrant_3.earn_permit
      expect(@facility_1.administer_road_test(@registrant_3)).to be false #=> false

      expect(@facility_1.administer_road_test(@registrant_1)).to be false #=> false
      @facility_1.administer_written_test(@registrant_1)
      expect(@facility_1.administer_road_test(@registrant_1)).to be true #=> true
      expect(@registrant_1.license_data[:license]).to be true #=> true

      @facility_1.administer_written_test(@registrant_2)
      expect(@facility_1.administer_road_test(@registrant_2)).to be false #=> false
      @registrant_2.license_data[:written] = true
      expect(@facility_1.administer_road_test(@registrant_2)).to be true #=> true
      expect(@registrant_2.license_data[:license]).to be true #=> true
    end
  end

  describe '#renew_drivers_license' do
    it 'can renew drivers licenses' do
      @facility_1.add_service('Written Test')
      @facility_1.add_service('Road Test')
      @facility_1.add_service('Renew License')

      expect(@facility_1.renew_drivers_license(@registrant_1)).to be false #=> false
      @facility_1.administer_written_test(@registrant_1)
      @facility_1.administer_road_test(@registrant_1)
      expect(@facility_1.renew_drivers_license(@registrant_1)).to be true #=> true
      expect(@registrant_1.license_data[:renewed]).to be true #=> true

      expect(@facility_1.renew_drivers_license(@registrant_3)).to be false #=> false
      expect(@registrant_3.license_data[:renewed]).to be false #=> false

      @facility_1.administer_written_test(@registrant_2)
      @facility_1.administer_road_test(@registrant_2)
      @registrant_2.license_data[:license] = true
      expect(@facility_1.renew_drivers_license(@registrant_2)).to be true #=> true
      expect(@registrant_2.license_data[:renewed]).to be true #=> true
    end
  end
end