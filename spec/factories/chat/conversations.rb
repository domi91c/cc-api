FactoryBot.define do
  factory :chat_conversation, class: 'Chat::Conversation' do
    owner { nil }
  end
end
