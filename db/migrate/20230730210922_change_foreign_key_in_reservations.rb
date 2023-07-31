class ChangeForeignKeyInReservations < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :reservations, column: :service_id

    remove_index :reservations, name: 'index_reservations_on_service_id'

    remove_column :reservations, :service_id
  end
end
