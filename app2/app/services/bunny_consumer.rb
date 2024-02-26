class BunnyConsumer
  require 'bunny'

  def initialize
    @connection = Bunny.new(hostname: ENV.fetch('RABBITMQ_HOSTNAME'),
                            username: ENV.fetch('RABBITMQ_USERNAME'),
                            password: ENV.fetch('RABBITMQ_PASSWORD')).start
    @channel = @connection.create_channel
  rescue StandardError => e
    Rails.logger.error { "\n\n[ERROR] RabbitMQ Consumer connection falied: #{e.message}\n\n" }

    @connection.close if @connection.present?
  end

  def receive(queue:)
    return unless connection.present? && channel.present?

    Rails.logger.info '[*] Waiting for messages. To exit press CTRL+C'
    queue = channel.queue(queue)
    queue.subscribe(block: true) do |_delivery_info, _properties, payload|
      Rails.logger.info { "\n\n[SUCCESS] RabbitMQ Consumer received successfully \n\n #{payload} \n\n" }
    end

    connection.close
  end

  private

  attr_reader :connection, :channel
end
