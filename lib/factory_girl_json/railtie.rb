module FactoryGirlJson
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'tasks/factory_girl_json.rake'
    end
  end
end