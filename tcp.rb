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
MongoMapper.database = "cabin"
ModBus::TCPClient.connect('classic', 502) do |cl|
    cl.with_slave(1) do |slave|
       	ampHours = slave.holding_registers[4124] #  daily amp hours
       	dispavgVbatt = slave.holding_registers[4114] #  average battery voltage
       	dispavgVpv = slave.holding_registers[4115]  #  average pv current
       	ibattDisplayS = slave.holding_registers[4116]  #  average battery current
       	watts = slave.holding_registers[4118]  #  average pwer to battery
       	state = slave.holding_registers[4119]  #  battery charge state
	soc = slave.holding_registers[4372]
	amps = slave.holding_registers[4370]
	whizzbang = slave.holding_registers[4360..4374]
	c = Classic.new
	c.dateTime = DateTime.now
	c.ampHours = ampHours[0]
	c.dispavgVbatt = dispavgVbatt[0]
	c.dispavgVpv = dispavgVpv[0] 
	c.ibattDisplayS = ibattDisplayS[0] 
	c.watts = watts[0]
	c.whizzbang = whizzbang
	c.soc = soc[0]
	c.amps = amps[0]
	c.state = state[0] >> 8
	c.save
    end
    cl.close
end
