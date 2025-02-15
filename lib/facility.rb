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
    if (@services.include?('Vehicle Registration'))
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
    else 
      return
    end
  end

  def administer_written_test(registrant)
    if (@services.include?('Written Test') || registrant.permit? && registrant.age >= 16)
      registrant.license_data[:written] = true
      true
    else
      return false
    end
  end

  def administer_road_test(registrant)
    if (@services.include?('Road Test') && registrant.license_data[:written])
      registrant.license_data[:license] = true
      true
    else
      return false
    end
  end

  def renew_drivers_license(registrant)
    if (@services.include?('Renew License') && registrant.license_data[:license])
      registrant.license_data[:renewed] = true
      true
    else
      return false
    end
  end
end