require 'mongo_mapper'
require 'temp'

class Raspberry
  include MongoMapper::Document

  key :dateTime,Time 
  key :inside, String
  key :outside, String
end
