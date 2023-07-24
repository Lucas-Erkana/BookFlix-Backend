class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :name
      t.float :price
      t.string :image
      t.string :details
      t.float :duration
      t.float :rating
      t.string :trailer
      t.timestamps
    end
  end
end
