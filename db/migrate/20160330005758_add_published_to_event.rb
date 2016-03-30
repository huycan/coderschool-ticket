class AddPublishedToEvent < ActiveRecord::Migration
  def change
    add_column :events, :published, :boolean, default: false, null: false
  end
end
