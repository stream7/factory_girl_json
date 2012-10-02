require 'factory_girl_json'
require 'active_record'
require 'models/user'
require 'models/post'
require 'serializers/user_serializer'
require 'factories/posts'
require 'factories/users'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => ':memory:'
)

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users, :force => true do |t|
    t.string :name
    t.string :email
    t.integer :age
  end

  create_table :posts, :force => true do |t|
    t.integer :user_id
    t.string :title
    t.text :body
  end

end