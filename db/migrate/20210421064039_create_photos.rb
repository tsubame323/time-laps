class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.string :image
      t.date :date
      t.references :folder, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
