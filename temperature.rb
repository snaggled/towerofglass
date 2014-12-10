$:.unshift File.dirname(__FILE__)

require 'raspberry'
require 'temp'
require 'net/http'


MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
MongoMapper.database = "raspberry"

r = Raspberry.new
r.dateTime = DateTime.now
r.inside = Temperature.get('inside').in_fahrenheit
r.outside = Temperature.get('outside').in_fahrenheit
r.save
