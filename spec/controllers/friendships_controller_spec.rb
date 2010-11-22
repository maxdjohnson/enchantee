require 'spec_helper'

describe FriendshipsController do

  def mock_friendship(stubs={})
    @mock_friendship ||= mock_model(Friendship, stubs)
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created friendship as @friendship" do
        Friendship.stub(:new).with({'these' => 'params'}).and_return(mock_friendship(:save => true))
        post :create, :friendship => {:these => 'params'}
        assigns[:friendship].should equal(mock_friendship)
      end

      it "redirects to the created friendship" do
        Friendship.stub(:new).and_return(mock_friendship(:save => true))
        post :create, :friendship => {}
        response.should redirect_to(friendship_url(mock_friendship))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved friendship as @friendship" do
        Friendship.stub(:new).with({'these' => 'params'}).and_return(mock_friendship(:save => false))
        post :create, :friendship => {:these => 'params'}
        assigns[:friendship].should equal(mock_friendship)
      end

      it "re-renders the 'new' template" do
        Friendship.stub(:new).and_return(mock_friendship(:save => false))
        post :create, :friendship => {}
        response.should render_template('new')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested friendship" do
      Friendship.should_receive(:find).with("37").and_return(mock_friendship)
      mock_friendship.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the friendships list" do
      Friendship.stub(:find).and_return(mock_friendship(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(friendships_url)
    end
  end

end
