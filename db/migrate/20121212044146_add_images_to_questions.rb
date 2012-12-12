class AddImagesToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :image1, :string
    add_column :questions, :image2, :string
    add_column :questions, :image3, :string
  end
end
