class CreateServers < ActiveRecord::Migration[5.1]
  def change
    create_table :servers do |t|
      t.string :login
      t.string :pass
      t.string :domain
      t.string :host

      t.timestamps
    end
  end
end
