$:.unshift File.dirname(__FILE__)

require 'raspberry'
require 'temp'
require 'net/http'

MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
MongoMapper.database = "raspberry"

url = URI.parse('http://192.168.1.24/cgi-bin/inside.cgi')
req = Net::HTTP::Get.new(url.to_s)
res = Net::HTTP.start(url.host, url.port) {|http|
          http.request(req)
}
inside = Temperature.new(:c => /\st=(\d+)/.match(res.body)[1].to_f / 1000)


url = URI.parse('http://192.168.1.24/cgi-bin/outside.cgi')
req = Net::HTTP::Get.new(url.to_s)
res = Net::HTTP.start(url.host, url.port) {|http|
          http.request(req)
}
outside = Temperature.new(:c => /\st=(\d+)/.match(res.body)[1].to_f / 1000)

r = Raspberry.new
r.dateTime = DateTime.now
r.inside = inside.in_fahrenheit
r.outside = outside.in_fahrenheit
r.save
