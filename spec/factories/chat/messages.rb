FactoryBot.define do
  factory :chat_message, class: 'Chat::Message' do
    conversation { "" }
    body { "MyText" }
    sender { "" }
    recipient { "" }
  end
end
