require 'spec_helper'

describe StaticPagesController do

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
  end

  describe "GET 'mail_confirmation'" do
    it "returns http success" do
      get 'mail_confirmation'
      response.should be_success
    end
  end

end
