$:.unshift File.dirname(__FILE__)

require 'json'
require 'classic'
require 'bandwidth'
require 'net/http'

class Fixnum
  def convert_base(to)
    self.to_s(to).to_i
  end
end

def post(r, destination)
     @host = "towerofglass.herokuapp.com"
     #@host = "localhost"
     @port = 80
     #@port = 3030
     @post_ws = "/widgets/#{destination}"
     @payload = r.to_json

     req = Net::HTTP::Post.new(@post_ws, initheader = {'Content-Type' =>'application/json'})
     req.body = @payload
     response = Net::HTTP.new(@host, @port).start {|http| http.request(req) }
     puts "Response #{response.code} #{response.message}:#{response.body}"
 end

MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
MongoMapper.database = "cabin"

# charge
classic = Classic.last()
soc = classic.soc.tr('[]', '')
state = {0 => 'Off', 
         3 => 'Absorb', 
         4 => 'Bulk', 
         5 => 'Float', 
         6 => 'Float', 
         7 => 'Equalize', 
         10 => 'Error', 
         18 => 'Equalizing'}
puts state[classic.state.to_i]

# graph
points = []
i = 0
classics = Classic.sort(:dateTime.desc).limit(24).to_a.reverse!
for c in classics do
    x = c.dateTime.hour - 6
    next if x < 0
    points << { x: x, y: c.dispavgVpv.tr('[]', '').to_i/10 }
i = i + 1
end

# bandwidth
b = Bandwidth.last()

# voltage
post({'current' => classic.dispavgVbatt.to_f/10, 'auth_token' => 'hoopla'}, 'voltage')
post({'points' => points, 'auth_token' => 'hoopla'}, 'pv')
post({'value' => soc, 'moreinfo' => state[classic.state.to_i], 'auth_token' => 'hoopla'}, 'soc')
post({'text' => b.bandwidth, 'auth_token' => 'hoopla'}, 'data')
