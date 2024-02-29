require_relative 'config/environment'
require_relative 'app/services/bunny_consumer'

p 'Starting Rabbitmq Consumer...'

Process.daemon

bunny_consumer = BunnyConsumer.new
bunny_consumer.receive(queue: 'policies')