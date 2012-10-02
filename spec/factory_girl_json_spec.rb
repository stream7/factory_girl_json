require 'spec_helper'

describe FactoryGirlJson do 
  it "should genarate a file" do
    FactoryGirlJson.export('user')
    path = "#{Dir.pwd}/user.json"
    File.exists?(path).should be_true
    File.delete path
  end
  
  it "should genarate a file with user json" do
    FactoryGirlJson.export('user')
    path = "#{Dir.pwd}/user.json"
    File.exists?(path).should be_true
    hash = JSON.parse(File.read(path))
    user = hash['user']
    user['id'].should_not be_nil
    user['name'].should_not be_nil
    user['email'].should_not be_nil
    user['age'].should_not be_nil
    File.delete path
  end

  it "should use json_serializer if present" do
    FactoryGirlJson.export('user_with_posts')
    path = "#{Dir.pwd}/user_with_posts.json"
    File.exists?(path).should be_true
    hash = JSON.parse(File.read(path))
    user = hash['user']
    user['id'].should_not be_nil
    user['name'].should_not be_nil
    user['email'].should_not be_nil
    user['age'].should_not be_nil
    user['posts'].should_not be_nil
    user['posts'][0]['post']['title'].should_not be_nil
    File.delete path
  end


  describe ".export_all" do
    it "should export three files" do
      FactoryGirlJson.export_all  
      Dir['*.json'].size.should eq(3)
      Dir['*.json'].each {|f| File.delete(f) }
    end
  end


  describe ".export_serialized" do
    it "should export three files" do
      FactoryGirlJson.export_serialized  
      Dir['*.json'].size.should eq(1)
      Dir['*.json'].first.should eq('user_with_posts.json')
      Dir['*.json'].each {|f| File.delete(f) }
    end
  end

end