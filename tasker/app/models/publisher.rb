class Publisher
  def self.publish(exchange, message = {})
    # grab the fanout exchange
    x = channel.fanout("blog.#{exchange}")
    # and simply publish message
    x.publish(message.to_json)
  end

  def self.channel
    @channel ||= connection.create_channel
  end

  # We are using default settings here
  # The `Bunny.new(...)` is a place to
  # put any specific RabbitMQ settings
  # like host or port
  def self.connection
    @connection ||= Bunny.new.tap do |c|
      c.start
    end
  end
end