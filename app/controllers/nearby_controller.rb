class NearbyController < ApplicationController
  
  RADIUS = 0.2
  
  def index
    redirect_to :action => 'map'
  end
  
  def list
    @users = User.find(:all, :origin => current_user, :within => RADIUS, :order => 'distance')
  end
  
  def map
    @users = User.find(:all, :origin => current_user, :within => RADIUS, :order => 'distance')
  end
end