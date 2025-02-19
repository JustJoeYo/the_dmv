require 'spec_helper'
require './lib/facility_factory'
require './lib/dmv_data_service'

RSpec.describe FacilityFactory do
  before(:each) do
    @facility_factory = FacilityFactory.new
    @co_dmv_office_locations = DmvDataService.new.co_dmv_office_locations
    @ny_dmv_office_locations = DmvDataService.new.ny_dmv_office_locations
    @mo_dmv_office_locations = DmvDataService.new.mo_dmv_office_locations
  end

  describe '#initialize' do
    it 'creates facility Colorado' do
      facilities = @facility_factory.create_facilities(@co_dmv_office_locations, :co)

      expect(facilities).to be_an(Array)
      expect(facilities.first).to be_a(Facility)

      first_facility_data = @co_dmv_office_locations.first
      expect(facilities.first.name).to eq(first_facility_data[:dmv_office])
      expect(facilities.first.address).to eq("#{first_facility_data[:address_li]} #{first_facility_data[:address__1]}, #{first_facility_data[:city]}, #{first_facility_data[:state]} #{first_facility_data[:zip]}")
      expect(facilities.first.phone).to eq(first_facility_data[:phone])
    end

    it 'creates facility New York' do
      facilities = @facility_factory.create_facilities(@ny_dmv_office_locations, :ny)

      expect(facilities).to be_an(Array)
      expect(facilities.first).to be_a(Facility)

      first_facility_data = @ny_dmv_office_locations.first
      expect(facilities.first.name).to eq(first_facility_data[:office_name])
      expect(facilities.first.address).to eq("#{first_facility_data[:street_address_line_1]} #{first_facility_data[:street_address_line_2]}, #{first_facility_data[:city]}, #{first_facility_data[:state]} #{first_facility_data[:zip_code]}")
      expect(facilities.first.phone).to eq(first_facility_data[:public_phone_number])
    end

    it 'creates facility Missouri' do
      facilities = @facility_factory.create_facilities(@mo_dmv_office_locations, :mo)

      expect(facilities).to be_an(Array)
      expect(facilities.first).to be_a(Facility)

      first_facility_data = @mo_dmv_office_locations.first
      expect(facilities.first.name).to eq(first_facility_data[:name])
      expect(facilities.first.address).to eq("#{first_facility_data[:address1]} #{first_facility_data[:address2]}, #{first_facility_data[:city]}, #{first_facility_data[:state]} #{first_facility_data[:zipcode]}")
      expect(facilities.first.phone).to eq(first_facility_data[:phone])
    end
  end
end