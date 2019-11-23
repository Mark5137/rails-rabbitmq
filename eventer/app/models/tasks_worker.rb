class TasksWorker
  include Sneakers::Worker

  from_queue "dashboard.tasks", env: nil

  def work(raw_post)
    Event.create(JSON.parse(raw_post).slice('title', 'description'))
    ack! # we need to let queue know that message was received
  end
end