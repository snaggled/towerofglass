require 'mongo_mapper'

class Classic
  include MongoMapper::Document

  key :dateTime,Time 
  key :inside, Float
  key :outside, Float
end
