#require './lib/classic'

SCHEDULER.every '1h' do
#    MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
#    MongoMapper.database = "cabin"
#    soc = Classic.last().soc.tr('[]', '')
    soc = "50"
    print soc
    send_event('soc', {value:soc.to_i})
end
