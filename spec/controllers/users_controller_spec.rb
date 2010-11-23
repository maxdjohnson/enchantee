require 'spec_helper'

describe UsersController do

  def mock_user(stubs={})
    stubs[:interests] ||= []
    @mock_user ||= mock_model(User, stubs)
  end
  
  def mock_interest(stubs={})
    @mock_interest ||= mock_model(Interest, stubs)
  end
  
  before(:each) do
  end
  
  describe "GET show" do
    it "assigns the requested user as @user" do
      controller.stub(:current_user).and_return(mock_model(User))
      User.stub(:find).with("37").and_return(mock_user)
      get :show, :id => "37"
      assigns[:user].should equal(mock_user)
    end
  end

  describe "GET new" do
    it "assigns a new user as @user" do
      User.stub(:new).and_return(mock_user)
      get :new
      assigns[:user].should equal(mock_user)
    end
  end

  describe "GET edit" do
    it "assigns the requested user as @user" do
      controller.stub(:current_user).and_return(mock_model(User))
      User.stub(:find).with("37").and_return(mock_user)
      get :edit, :id => "37"
      assigns[:user].should equal(mock_user)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created user as @user" do
        User.stub(:new).with({'these' => 'params'}).and_return(mock_user(:save => true))
        post :create, :user => {:these => 'params'}
        assigns[:user].should equal(mock_user)
      end

      it "redirects to the created user" do
        User.stub(:new).and_return(mock_user(:save => true))
        post :create, :user => {}
        response.should redirect_to(user_url(mock_user))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        User.stub(:new).with({'these' => 'params'}).and_return(mock_user(:save => false))
        post :create, :user => {:these => 'params'}
        assigns[:user].should equal(mock_user)
      end

      it "re-renders the 'new' template" do
        User.stub(:new).and_return(mock_user(:save => false))
        post :create, :user => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do
    before(:each) do
      controller.stub(:current_user).and_return(mock_model(User))
    end

    describe "with valid params" do
      it "updates the requested user" do
        User.should_receive(:find).with("37").and_return(mock_user)
        mock_user.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :user => {:these => 'params'}
      end

      it "assigns the requested user as @user" do
        User.stub(:find).and_return(mock_user(:update_attributes => true))
        put :update, :id => "1"
        assigns[:user].should equal(mock_user)
      end

      it "redirects to the user" do
        User.stub(:find).and_return(mock_user(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(user_url(mock_user))
      end
    end

    describe "with invalid params" do
      it "updates the requested user" do
        User.should_receive(:find).with("37").and_return(mock_user)
        mock_user.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :user => {:these => 'params'}
      end

      it "assigns the user as @user" do
        User.stub(:find).and_return(mock_user(:update_attributes => false))
        put :update, :id => "1"
        assigns[:user].should equal(mock_user)
      end

      it "re-renders the 'edit' template" do
        User.stub(:find).and_return(mock_user(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    before(:each) do
      controller.stub(:current_user).and_return(mock_model(User))
    end
    
    it "destroys the requested user" do
      User.should_receive(:find).with("37").and_return(mock_user)
      mock_user.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the users list" do
      User.stub(:find).and_return(mock_user(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(users_url)
    end
  end
  
  describe "DELETE remove_interest" do
    it "should remove the interest" do
      controller.stub(:current_user).and_return(mock_model(User))
      Interest.should_receive(:find).and_return(mock)
      User.stub(:find).and_return(mock_model(User, :interests => mock(:delete => true)))
      delete :remove_interest, :id => "1"
    end
  end
end
