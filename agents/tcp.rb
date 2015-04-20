$:.unshift File.dirname(__FILE__)

require 'rmodbus'
require 'json'
require 'classic'

class Fixnum
  def convert_base(to)
    self.to_s(to).to_i
  end
end

MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
MongoMapper.database = "classic"
ModBus::TCPClient.connect('100.125.73.147', 502) do |cl|
    cl.with_slave(1) do |slave|
       	ampHours = slave.holding_registers[4124]
       	dispavgVbatt = slave.holding_registers[4114]
       	dispavgVpv = slave.holding_registers[4115]
       	ibattDisplayS = slave.holding_registers[4116]
       	watts = slave.holding_registers[4118]
	registers = slave.holding_registers[4100..4200]
	c = Classic.new
	c.dateTime = DateTime.now
	c.ampHours = ampHours
	c.dispavgVbatt = dispavgVbatt 
	c.dispavgVpv = dispavgVpv 
	c.ibattDisplayS = ibattDisplayS 
	c.watts = watts
	c.registers = registers
	c.save
    end
    cl.close
end
