class RenameNicknameToUsernameOnUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :nickname, :username
  end
end
