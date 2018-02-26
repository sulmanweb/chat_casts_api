class CreateVerifications < ActiveRecord::Migration[5.1]
  def change
    create_table :verifications do |t|
      t.references :user, foreign_key: true
      t.integer :v_type, null: false
      t.integer :status, null: false
      t.string :token, null: false, default: ''

      t.timestamps
    end
  end
end
