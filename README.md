# FactoryGirlJson

This gem facilitates the creation of JSON fixtures for javascript testing in ruby apps.
While testing composite views in front end "MVC" frameworks (Backbone, Emder, Angular etc) 
you might need to create some quite complicated json fixtures to seed the models for the tests.

This gem will use your `FactoryGirl` factories to create these json fixtures for you.

Furthermore it supports custom serializers (e.g. [`active_model_serializers`](https://github.com/josevalim/active_model_serializers) or any class that takes a model in its constructor and responds to `to_json`).

The fixtures can be loaded in your tests using a javascript library such as [jasmine-jquery](https://github.com/velesin/jasmine-jquery#json-fixtures).

## Installation

The gem has been used only in a Rails project in combination with `factory_girl_rails` but it should work with `factory_girl` gem as well.

Add these lines to your application's Gemfile:
    
    group :test do
      gem 'factory_girl_rails'
      gem 'factory_girl_json'
    end


And then execute:

    $ bundle

Or install it yourself as:

    $ gem install factory_girl_json

## Usage

First, define some factories with factory girl. 
You can add another option `json_serializer` which indicates which class will be used for the serialization of the model.

    FactoryGirl.define do
      factory :user do
        sequence(:name) {|n| "user name #{n}"}
        sequence(:email) {|n| "useremail#{n}@email.com"}
        age 12
      end

      factory :user_with_posts, parent: :user, json_serializer: UserSerializer do
        after(:create) do |user|
          create :post, user: user
        end
      end
    end


    class UserSerializer
      def initialize(user)
        @user = user
      end

      def to_json(options = {})
        posts = {posts: @user.posts.as_json}
        user = @user.as_json
        user['user'].merge! posts
        JSON.generate user
      end
    end


Now if you run this command

`RAILS_ENV=test bundle exec rake factory_girl_json:export['user']`

you will get a `user.json` file with data:

    {
      "user": {
        "age": 12,
        "email": "useremail1@email.com",
        "id": 1,
        "name": "user name 1"
      }
    }

`RAILS_ENV=test bundle exec rake factory_girl_json:export['user_with_posts']`

you will get a `user_with_posts.json` file with data:

    {
      "user": {
        "age": 12,
        "email": "useremail1@email.com",
        "id": 1,
        "name": "user name 1",
        "posts": [
          {
            "post": {
              "body": "post body",
              "id": 1,
              "title": "post title",
              "user_id": 1
            }
          }
        ]
      }
    }

### All rake tasks
    rake factory_girl_json:all                        # Exports json fixtures for all FactoryGirl factories
    rake factory_girl_json:export[factory_name]       # Exports json fixture for the selected FactoryGirl factory
    rake factory_girl_json:export_serialized          # Exports json fixtures for FactoryGirl factories with the json_serializer option

### Default exporting paths
if Rails is used it will write the json files to `spec\javascripts\fixtures\json` or `test\javascripts\fixtures\json`
otherwise it uses the current path.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Author

[Nikos Gereoudakis](https://twitter.com/ni_ger)