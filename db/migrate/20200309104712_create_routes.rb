class CreateRoutes < ActiveRecord::Migration[5.2]
  def change
    create_table :routes do |t|
      t.string :name
      t.string :acronym

      t.timestamps
    end
  end
end
