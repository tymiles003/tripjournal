namespace :tj do
  task sync: :environment do
    SyncJob.perform_later
  end
end
