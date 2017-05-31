class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :AccountName
      t.string :cn
      t.string :objectclass
      t.string :dn
      t.references :server, foreign_key: true

      t.timestamps
    end
  end
end
