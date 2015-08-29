class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def instagram
    status = if params[:auth_token] == ENV['INSTAGRAM_IFTTT_TOKEN']
               SyncJob.perform_later
               :ok
             else
               :unauthorized
             end
    head status
  end

end
