require 'mongo_mapper'
require './lib/temp'

class Raspberry
  include MongoMapper::Document

  key :dateTime,Time 
  key :inside, String
  key :outside, String
end
