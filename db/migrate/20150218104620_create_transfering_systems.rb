class CreateTransferingSystems < ActiveRecord::Migration
  def change
    create_table :transfering_systems do |t|

      t.timestamps
    end
  end
end
