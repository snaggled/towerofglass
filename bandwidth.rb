require 'mongo_mapper'

class Classic
  include MongoMapper::Document

  key :dateTime,Time 
  key :ampHours, String
  key :dispavgVbatt, String
  key :dispavgVpv , String
  key :ibattDisplayS , String
  key :watts, String
  key :soc, String
  key :state, String
  key :amps, String
  key :registers, Array
  key :whizzbang, Array
end

class Bandwidth
  include MongoMapper::Document
  key :bandwidth, String
end
