class WelcomeController < ApplicationController
  
  skip_before_filter :authentication_needed
  
  def home
    
  end
  
  def not_home
    
  end

  
end
