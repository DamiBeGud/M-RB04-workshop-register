class CreateDomain < ActiveRecord::Migration[8.1]
 def change
create_table(:workshops){|t|t.string :code,null:false,limit:64;t.integer :capacity,null:false}
add_index :workshops,:code,unique:true
add_check_constraint :workshops,'capacity BETWEEN 1 AND 100',name:'workshop_capacity_valid'
create_table(:registrations){|t|t.references :workshop,null:false,foreign_key:true;t.string :attendee_ref,null:false,limit:64;t.boolean :active,null:false,default:true}
add_index :registrations,[:workshop_id,:attendee_ref],unique:true
 end
end
