require 'spec_helper'

describe PagesController do
  include Devise::TestHelpers

  render_views

  before(:each) do
    @base_title = "Skygodlin | "
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end

    it "should have the right title" do
      get 'contact'
      response.should have_selector("title",
                        :content => @base_title + "Contact" )
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end

    it "should have the right title" do
      get 'about'
      response.should have_selector("title",
                        :content => @base_title + "About")
    end
  end

  describe "GET 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end

    it "should have the right title" do
      get 'help'
      response.should have_selector("title",
                        :content => @base_title + "Help")
    end
  end

  describe "GET 'terms'" do
    it "should be successful" do
      get 'terms'
      response.should be_success
    end

    it "should have the right title" do
      get 'terms'
      response.should have_selector("title",
                        :content => @base_title + "Terms of Use")
    end
  end

  describe "GET 'privacy'" do
    it "should be successful" do
      get 'privacy'
      response.should be_success
    end

    it "should have the right title" do
      get 'privacy'
      response.should have_selector("title",
                        :content => @base_title + "Privacy Policy")
    end
  end
end

