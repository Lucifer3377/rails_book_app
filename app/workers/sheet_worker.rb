class SheetWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker # enables job status tracking

  sidekiq_options retry: false
  
  def perform(*args)
    Author.import(args[0],args[1],args[2]) 
  end

end
