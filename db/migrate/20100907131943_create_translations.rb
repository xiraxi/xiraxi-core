class CreateTranslations < ActiveRecord::Migration
  def self.up
    create_table :translations do |t|
      t.string :key,    :null => false, :limit => 1_000
      t.string :locale, :null => false
      t.string :text,   :null => false, :limit => 10_000

      t.timestamps
    end

    add_index :translations, [:key, :locale], :unique => true
  end

  def self.down
    drop_table :translations
  end
end
