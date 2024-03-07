class BunnyConsumer
  require 'bunny'

  def initialize
    @connection = Bunny.new(hostname: ENV.fetch('RABBITMQ_HOSTNAME'),
                            username: ENV.fetch('RABBITMQ_USERNAME'),
                            password: ENV.fetch('RABBITMQ_PASSWORD')).start
    @channel = @connection.create_channel
  rescue StandardError => e
    Rails.logger.error { "\n\n[ERROR] RabbitMQ Consumer connection failed: #{e.message}\n\n" }

    @connection.close if @connection.present?
  end

  def receive(queue:)
    return unless connection.present? && channel.present?

    Rails.logger.info '[*] Waiting for messages. To exit press CTRL+C'
    queue = channel.queue(queue)
    queue.subscribe(block: true) do |_delivery_info, _properties, payload|
      Rails.logger.info { "\n\n[SUCCESS] RabbitMQ Consumer received successfully \n\n #{payload} \n\n" }

      begin
        data = JSON.parse(payload)

        if data['provider'] == 'oauth2'
          create_user(data)
        else
          create_policy(data)
        end

      rescue StandardError => e
        puts "Error creating record: #{e.message}"
      end
    end
  end

  private

  def create_user(user_data)
    user = User.create!(user_data.slice('email', 'uid', 'provider'))

    user.create_user_info!(user_data['info'])
  end

  def create_policy(policy_data)
    policy = Policy.create!(policy_data.slice('issue_date', 'coverage_end_date', 'policy_id'))

    insured_data = policy_data['insured'].merge(policy_id: policy.id)

    insured = Insured.create!(insured_data)

    vehicle_data = policy_data['vehicle'].merge(policy_id: policy.id)
    vehicle = Vehicle.create!(vehicle_data)
  end

  attr_reader :connection, :channel
end
