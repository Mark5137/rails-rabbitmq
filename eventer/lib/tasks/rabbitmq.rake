namespace :rabbitmq do
  desc "Setup routing"
  task :setup do
    require "bunny"

    conn = Bunny.new
    conn.start

    ch = conn.create_channel

    # get or create exchange
    x = ch.fanout("blog.tasks")

    # get or create queue (note the durable setting)
    queue = ch.queue("dashboard.tasks", durable: true)

    # bind queue to exchange
    queue.bind("blog.tasks")

    conn.close
  end
end