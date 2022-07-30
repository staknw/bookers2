class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    # create_table :テーブル名
    create_table :books do |t|
      # t.データ型 :カラム名
      t.string :title
      t.text :body
      t.integer :user_id

      t.timestamps
    end
  end
end
