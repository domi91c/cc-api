class CreateChatMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_messages do |t|
      t.references :conversation
      t.text :body
      t.references :sender
      t.references :recipient

      t.timestamps
    end
  end
end
