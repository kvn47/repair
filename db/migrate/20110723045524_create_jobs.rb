class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.integer :model_id
      t.string :serial
      t.boolean :status
      t.text :comment
      t.decimal :price
      t.integer :master_id
      t.datetime :income_date
      t.string :supplier
      t.boolean :guarantee

      t.timestamps
    end
  end

  def self.down
    drop_table :jobs
  end
end
