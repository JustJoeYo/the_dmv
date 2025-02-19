require './lib/facility'

class FacilityFactory
  def create_facilities(data, state)
    data.map do |facility_data|
      case state # most efficient way to cycle through that i know of
      when :co
        Facility.new({
          name: facility_data[:dmv_office],
          address: "#{facility_data[:address_li]} #{facility_data[:address__1]}, #{facility_data[:city]}, #{facility_data[:state]} #{facility_data[:zip]}",
          phone: facility_data[:phone]
        })
      when :ny
        Facility.new({
          name: facility_data[:office_name],
          address: "#{facility_data[:street_address_line_1]} #{facility_data[:street_address_line_2]}, #{facility_data[:city]}, #{facility_data[:state]} #{facility_data[:zip_code]}",
          phone: facility_data[:public_phone_number]
        })
      when :mo
        Facility.new({
          name: facility_data[:name],
          address: "#{facility_data[:address1]} #{facility_data[:address2]}, #{facility_data[:city]}, #{facility_data[:state]} #{facility_data[:zipcode]}",
          phone: facility_data[:phone]
        })
      else
        raise "no dmv for state: #{state}"
      end
    end
  end
end