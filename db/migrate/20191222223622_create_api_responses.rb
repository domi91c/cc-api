class CreateApiResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :api_responses do |t|
      t.json :response
      t.string :api
      t.string :kind
      t.references :owner, polymorphic: true, null: false

      t.timestamps
    end
  end
end
