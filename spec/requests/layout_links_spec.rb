require 'spec_helper'

describe "LayoutLinks" do

  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => "Home")
  end

  it "should have a Contact page at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => "Contact")
  end

  it "should have an About page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => "About")
  end

  it "should have a Help page at '/help'" do
    get '/help'
    response.should have_selector('title', :content => "Help")
  end

  it "should have an Privacy Policy page at '/privacy'" do
    get '/privacy'
    response.should have_selector('title', :content => "Privacy Policy")
  end

  it "should have a Terms of Use page at '/terms'" do
    get '/terms'
    response.should have_selector('title', :content => "Terms of Use")
  end
end

