ActiveRecord::Base.establish_connection({:adapter => 'sqlite3', :database => ':memory:'})
ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define(:version => 1) do

  create_table :avatars, :force => true do |t|
    t.string   :url
    t.integer  :user_id
  end

  create_table :base_users, :force => true do |t|
    t.string   :full_name
  end

end

