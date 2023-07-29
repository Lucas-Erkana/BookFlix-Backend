class RenameServicesToMovies < ActiveRecord::Migration[7.0]
  def change
    rename_table :services, :movies
  end
end
