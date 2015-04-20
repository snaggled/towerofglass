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
  key :registers, Array
end
