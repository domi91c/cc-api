require 'colorize'

class CallChannel < ApplicationCable::Channel
  def subscribed
    # Rails.logger.debug("=======CALL CHANNEL=======SUBSCRIBING FOR #{current_user.email}".red)
    stream_for current_user
  end

  def unsubscribed;
  end
end
