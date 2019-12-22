class Chat::Conversation < ApplicationRecord
  belongs_to :owner, polymorphic: true
end
