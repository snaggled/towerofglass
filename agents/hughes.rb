$:.unshift File.dirname(__FILE__)

require 'json'
require 'bandwidth'
require 'net/http'
require 'nokogiri'

class Fixnum
  def convert_base(to)
    self.to_s(to).to_i
  end
end

MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
MongoMapper.database = "cabin"

url = "http://192.168.0.1/cgi-bin/index.cgi?Command=11"
uri = URI.parse(url)
http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Post.new(uri.request_uri)
#request.content_type = "text/xml"
#request.body = message
response = http.request(request)

doc = Nokogiri::HTML(response.body)
trs = doc.css('table > tr')
bandwidth = trs[3].css('td')[1].css('b')[0].text

b = Bandwidth.new
b.bandwidth = bandwidth
b.save
