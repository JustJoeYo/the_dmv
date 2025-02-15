require 'spec_helper'
require './lib/vehicle_factory'
require './lib/dmv_data_service'

RSpec.describe VehicleFactory do
  before(:each) do
    @vehicle_factory = VehicleFactory.new
    @wa_ev_registrations = DmvDataService.new.wa_ev_registrations
  end

  describe '#initialize' do
    it 'initialization' do
      expect(@vehicle_factory).to be_an_instance_of(VehicleFactory)
    end

    it 'has vehicles' do
      expect(@vehicle_factory.vehicles).to eq([])
    end
  end

  describe '#create_vehicles' do
    it 'creates vehicle objects from data' do
      vehicles = @vehicle_factory.create_vehicles(@wa_ev_registrations)

      expect(vehicles).to be_an(Array)
      expect(vehicles.first).to be_a(Vehicle)
      expect(vehicles.first.engine).to eq(:ev)

      first_vehicle_data = @wa_ev_registrations.first
      expect(vehicles.first.vin).to eq(first_vehicle_data[:vin_1_10])
      expect(vehicles.first.year).to eq(first_vehicle_data[:model_year])
      expect(vehicles.first.make).to eq(first_vehicle_data[:make])
      expect(vehicles.first.model).to eq(first_vehicle_data[:model])
    end
  end
end