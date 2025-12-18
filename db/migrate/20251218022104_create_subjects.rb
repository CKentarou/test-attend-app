class CreateSubjects < ActiveRecord::Migration[7.2]
  def change
    create_table :subjects do |t|
      t.string :name, null: false
      t.references :user, null: false, foreign_key: true
      t.integer :teacher_id, null: false, foreign_key: { to_table: :users }
      t.string :classroom, null: false

      t.timestamps
    end
  end
end
