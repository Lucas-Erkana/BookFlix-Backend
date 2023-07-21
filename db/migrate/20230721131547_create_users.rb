class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :full_name
      t.boolean :admin

      t.timestamps
    end
  end
end
