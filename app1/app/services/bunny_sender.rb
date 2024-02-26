class BunnySender
  require 'bunny'

  def initialize
    @connection = Bunny.new(hostname: ENV.fetch('RABBITMQ_HOSTNAME'),
                            username: ENV.fetch('RABBITMQ_USERNAME'),
                            password: ENV.fetch('RABBITMQ_PASSWORD')).start
    @channel = @connection.create_channel
  rescue StandardError => e
    Rails.logger.error { "\n\n \e[41m [ERROR] \e[0m RabbitMQ Sender connection falied: #{e.message}\n\n" }

    @connection.close if @connection.present?
  end

  def publish(data:, queue:)
    return unless connection.present? && channel.present?

    channel.default_exchange.publish(data, routing_key: channel.queue(queue).name)
    Rails.logger.info "\e[42m [SUCCESS] \e[0m RabbitMQ Sender published successfully"
    connection.close
  end

  private

  attr_reader :connection, :channel
end
