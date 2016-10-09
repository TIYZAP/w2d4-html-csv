require 'csv'
require 'erb'

info = CSV.foreach("planet_express_logs.csv", headers: true, :header_converters => :symbol)


class Delivery

  attr_accessor :destination, :shipment, :crates, :money, :pilot

  def initialize(destination:, shipment:, crates:, money:)
    @destination = destination
    @shipment = shipment
    @crates = crates
    @money = money.to_i
    determine_pilot
  end

  def determine_pilot
    if destination == " Earth"
      @pilot = "Fry"
    elsif destination == " Mars"
      @pilot = "Amy"
    elsif destination == " Uranus"
      @pilot = "Bender"
    else
      @pilot = "Leela"
    end
  end




end







log = info.collect {|row| Delivery.new(row)}

total = log.reduce(0) { |key, value| key + value.money }

# log.each { |trip| puts trip.inspect }

grouped_by_pilot = log.group_by {|job| job.pilot}

grouped_by_pilot.each {|job| job.inspect}

# puts total

new_file = File.open("./report.html", "w+")
new_file << ERB.new(File.read("report.erb")).result(binding)
new_file.close
