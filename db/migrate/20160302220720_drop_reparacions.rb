class DropReparacions < ActiveRecord::Migration
  def change
	drop_table :reparacions
  end
end
