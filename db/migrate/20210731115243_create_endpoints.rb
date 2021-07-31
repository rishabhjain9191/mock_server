class CreateEndpoints < ActiveRecord::Migration[6.1]
  def change
    create_table :endpoints do |t|
      t.string :path
      t.string :verb
      t.integer :response_code
      t.string :body

      t.timestamps
    end
  end
end
