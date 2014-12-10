class Temperature
    class << self
        def from_fahrenheit temp
            Temperature.new({f: temp})
        end

        def from_celsius temp
            Temperature.new({c: temp})
        end
    end

    def initialize(options={})
        @f = options[:f]
        @c = options[:c]
    end

    def self.get(location)
        url = "http://192.168.1.24/cgi-bin/%s.cgi" % location
            u = URI.parse(url)
            req = Net::HTTP::Get.new(u.to_s)
            res = Net::HTTP.start(u.host, u.port) do |http|
                http.request(req)
            end
            return self.new(:c => /\st=(\-?\d+)/.match(res.body)[1].to_f / 1000)
    end

    def in_fahrenheit
        return @f if @f
        (@c * (9.0 / 5.0)) + 32
    end

    def in_celsius
        return @c if @c
        (@f - 32) * 5.0 / 9.0
    end
end

class Celsius < Temperature
    def initialize temp
        super(c: temp)
    end
end

class Fahrenheit < Temperature
    def initialize temp
        super(f: temp)
    end
end
