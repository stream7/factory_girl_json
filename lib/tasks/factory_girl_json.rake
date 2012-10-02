namespace :factory_girl_json do

  desc 'Exports json fixtures for all FactoryGirl factories'
  task :all => :environment do
    FactoryGirlJson.export_all
  end
  
  desc 'Exports json fixture for the selected FactoryGirl factory'
  task :export, [:factory_name] => :environment do |t, args|
    FactoryGirlJson.export args[:factory_name]
  end

  desc 'Exports json fixtures for FactoryGirl factories with the json_serializer option'
  task :export_serialized => :environment do
    FactoryGirlJson.export_serialized
  end
end

