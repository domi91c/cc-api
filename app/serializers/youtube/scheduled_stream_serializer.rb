class Youtube::ScheduledStreamSerializer < ApplicationSerializer

  attributes :snippet

  def snippet

  end

  attribute(:id) { object['id'] }
  attribute(:title) { object['snippet']['title'] }
end
