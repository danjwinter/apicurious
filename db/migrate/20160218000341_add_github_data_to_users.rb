class AddGithubDataToUsers < ActiveRecord::Migration
  def change
    add_column :users, :githubdata, :text
  end
end
