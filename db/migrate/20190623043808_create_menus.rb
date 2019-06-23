class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.date :day
      t.string :lunch1
      t.string :lunch2
      t.string :dinner

      t.timestamps null: false
    end
  end
end
