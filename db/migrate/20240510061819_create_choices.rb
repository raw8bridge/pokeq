class CreateChoices < ActiveRecord::Migration[7.1]
  def change
    create_table :choices do |t|
      t.string :body
      t.boolean :is_correct, null: false, default: false
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
