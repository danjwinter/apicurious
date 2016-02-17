class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid
      t.string :provider
      t.string :token
      t.string :nickname
      t.string :email
      t.string :name
      t.string :image_url

      t.timestamps null: false
    end
  end
end
