module ApplicationHelper
  # validates :current_user
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  
  
  def page_title
    if content_for?(:title)
        "Movies - #{content_for(:title)}"
    else
        "Dr. Jones Movie Playground"
    end
    
  end
end
