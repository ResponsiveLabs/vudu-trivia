class DefaultsForQuestion < ActiveRecord::Migration
  def up
    change_column :questions, :explanation, :text, null: false
    change_column :questions, :title, :string, null: false

    change_column_default :questions, :points_to_earn, 10
    change_column_default :questions, :published, false
    change_column_default :questions, :timer_in_seconds, 60
  end

end
