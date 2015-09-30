class GenerateLabelsJob < ActiveJob::Base
  queue_as :default

  def perform
    # Do something later
      @labels ||= current_user.client.issues.labels.list
  end
end
