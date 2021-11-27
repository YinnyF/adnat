class CreateOrganisations < ActiveRecord::Migration[6.1]
  def change
    create_table :organisations do |t|
      t.string :name
      t.decimal :hourly_rate

      t.timestamps
    end
  end
end
