class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :image
      t.boolean :published, :default => false

      t.timestamps
    end
  end
end
