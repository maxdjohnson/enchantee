require 'spec_helper'

describe "/users/edit.html.erb" do
  include UsersHelper

  before(:each) do
    assigns[:user] = @user = stub_model(User,
      :new_record? => false,
      :username => "value for username",
      :password => "value for password",
      :first_name => "value for first_name",
      :last_name => "value for last_name",
      :photo => "value for photo",
      :latitude => 1.5,
      :longitude => 1.5
    )
  end

  it "renders the edit user form" do
    render

    response.should have_tag("form[action=#{user_path(@user)}][method=post]") do
      with_tag('input#user_username[name=?]', "user[username]")
      with_tag('input#user_password[name=?]', "user[password]")
      with_tag('input#user_first_name[name=?]', "user[first_name]")
      with_tag('input#user_last_name[name=?]', "user[last_name]")
      with_tag('input#user_photo[name=?]', "user[photo]")
      with_tag('input#user_latitude[name=?]', "user[latitude]")
      with_tag('input#user_longitude[name=?]', "user[longitude]")
    end
  end
end
