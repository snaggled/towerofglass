$:.unshift File.dirname(__FILE__)

require 'raspberry'
require 'temp'
require 'net/http'


MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
MongoMapper.database = "raspberry"

def get(location)
    url = "http://192.168.1.24/cgi-bin/%s.cgi" % location
    u = URI.parse(url)
    req = Net::HTTP::Get.new(u.to_s)
    res = Net::HTTP.start(u.host, u.port) do |http|
        http.request(req)
    end
    return Temperature.new(:c => /\st=(\-?\d+)/.match(res.body)[1].to_f / 1000)
end

r = Raspberry.new
r.dateTime = DateTime.now
r.inside = get('inside').in_fahrenheit
r.outside = get('outside').in_fahrenheit
r.save
