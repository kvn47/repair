module SessionsHelper

  def signed_in?
    !current_user.nil?
  end
  
  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    # cookies.signed[:remember_token] = {:value => [user.id, user.salt], :expires => 10.minute.from_now}
    self.current_user = user
  end
  
  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= user_from_remember_token
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def authenticate
    if User.any?
      (deny_access unless signed_in?)
    end    
  end
  
  def admin_user
    if User.any?
      redirect_to(root_path) unless current_user.admin?
    end
  end
  
  def signed_in_as_admin?
    signed_in? and current_user.is_admin?
  end
  
  def deny_access
    redirect_to signin_path
  end
  
  private
  
    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end
    
    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end
end
