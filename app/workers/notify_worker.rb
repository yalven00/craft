class NotifyWorker
  include Sidekiq::Worker

  def perform(ids)
    queue_size = Sidekiq::Queue.new.size
    if queue_size < 2
      begin
        CompanyMailer.imported(ids).deliver
      rescue => exception
        ExceptionNotifier.notify_exception(exception)
      end
    else
      NotifyWorker.perform_in(queue_size * 5.seconds, ids)
    end
  end
end
