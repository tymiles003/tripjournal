class SyncJob < ActiveJob::Base
  queue_as :default

  def perform
    InstagramSource.all.each(&:sync!)
  end
end
