require 'date'

class Facility
  attr_reader :name, :address, :phone, :services, :registered_vehicles, :collected_fees

  def initialize(attributes = {})
    @name = attributes[:name]
    @address = attributes[:address]
    @phone = attributes[:phone]
    @services = []
    @registered_vehicles = []
    @collected_fees = 0
  end

  def add_service(service)
    @services << service
  end

  def register_vehicle(vehicle)
    return unless @services.include?('Vehicle Registration')

    vehicle.registration_date = Date.today
    case vehicle.year
    when ->(year) { year <= Date.today.year - 25 }
      vehicle.plate_type = :antique
      @collected_fees += 25
    when ->(year) { vehicle.engine == :ev }
      vehicle.plate_type = :ev
      @collected_fees += 200
    else
      vehicle.plate_type = :regular
      @collected_fees += 100
    end
    @registered_vehicles << vehicle
  end

  def administer_written_test(registrant)
    return false unless @services.include?('Written Test')
    return false unless registrant.permit? && registrant.age >= 16

    registrant.license_data[:written] = true
    true
  end

  def administer_road_test(registrant)
    return false unless @services.include?('Road Test')
    return false unless registrant.license_data[:written]

    registrant.license_data[:license] = true
    true
  end

  def renew_drivers_license(registrant)
    return false unless @services.include?('Renew License')
    return false unless registrant.license_data[:license]

    registrant.license_data[:renewed] = true
    true
  end
end