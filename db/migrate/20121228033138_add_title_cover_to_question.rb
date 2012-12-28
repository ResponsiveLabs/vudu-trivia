class AddTitleCoverToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :title_cover, :string
  end
end
