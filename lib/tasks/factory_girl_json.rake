namespace :factory_girl_json do  
  desc 'Exports json fixture for the selected FactoryGirl factory'
  task :export, [:factory_name, :size, :serializer] => :environment do |t, args|
    FactoryGirlJson.export args[:factory_name], args[:size], args[:serializer]
  end
end

