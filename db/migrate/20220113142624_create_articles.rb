class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.integer :status, default: 0
      t.boolean :featured

      t.timestamps
    end
  end
end
