class AddAttachmentImagenToArchivos < ActiveRecord::Migration
  def self.up
    change_table :archivos do |t|
      t.attachment :imagen
    end
  end

  def self.down
    remove_attachment :archivos, :imagen
  end
end
