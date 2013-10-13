require 'spec_helper'

describe FactoryGirlJson do
  after(:each) do
    Dir['*.json'].each {|f| File.delete(f) }
  end

  it "should genarate a file" do
    FactoryGirlJson.export('user')
    path = "#{Dir.pwd}/user.json"
    File.exists?(path).should be_true
  end
  
  it "should genarate a file with user json" do
    FactoryGirlJson.export('user')
    path = "#{Dir.pwd}/user.json"
    File.exists?(path).should be_true
    user = JSON.parse(File.read(path))
    user['id'].should_not be_nil
    user['name'].should_not be_nil
    user['email'].should_not be_nil
    user['age'].should_not be_nil
  end

  it "should use the given serializer if present" do
    FactoryGirlJson.export('user_with_posts', 1, 'UserSerializer')
    path = "#{Dir.pwd}/user_with_posts.user_serializer.json"
    File.exists?(path).should be_true
    user = JSON.parse(File.read(path))
    user['id'].should_not be_nil
    user['name'].should_not be_nil
    user['email'].should_not be_nil
    user['age'].should_not be_nil
    user['posts'].should_not be_nil
    user['posts'][0]['title'].should_not be_nil
  end

  describe "exporting collections" do
    it "should export the requested size" do
      FactoryGirlJson.export('user', 4)
      path = "#{Dir.pwd}/4.user.json"
      File.exists?(path).should be_true
      users = JSON.parse(File.read(path))
      users.size.should be(4)
      user = users.first
      user['id'].should_not be_nil
      user['name'].should_not be_nil
      user['email'].should_not be_nil
      user['age'].should_not be_nil
    end

    it "should export the requested size with serializer" do
      FactoryGirlJson.export('user_with_posts', 2, 'UserSerializer')
      path = "#{Dir.pwd}/2.user_with_posts.user_serializer.json"
      File.exists?(path).should be_true
      users = JSON.parse(File.read(path))
      users.size.should be(2)
      user = users.first
      user['id'].should_not be_nil
      user['name'].should_not be_nil
      user['email'].should_not be_nil
      user['age'].should_not be_nil
      user['posts'].should_not be_nil
      user['posts'][0]['title'].should_not be_nil
    end
  end
end