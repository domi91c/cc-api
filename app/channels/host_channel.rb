class HostChannel < ApplicationCable::Channel
  def subscribed
    # Rails.logger.debug("========HOST CHANNEL========".green,"SUBSCRIBING FOR #{current_user.email}".red)
    stream_for current_user
  end

  def unsubscribed;
  end
end
