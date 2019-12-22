class CreateChatConversations < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_conversations do |t|
      t.references :owner, polymorphic: true, null: false

      t.timestamps
    end
  end
end
