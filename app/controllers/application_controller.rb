class ApplicationController < ActionController::Base
  include UrlHelper
  protect_from_forgery
  helper_method :current_account, :check_my_account, :root_domain
  before_filter :current_account
  before_filter :set_mailer_url_options

  def root_domain
    result = (request.subdomains.first.present? && request.subdomains.first != "www") ? false : true
  end

  def current_account
    if request.subdomains.first.present? && request.subdomains.first != "www"
      current_account = Account.find_by_name(request.subdomains.first)
      if current_account.nil?
        redirect_to root_url(:account => false, :alert => "Unknown Account/subdomain")
      end
    else
      current_account = nil
      flash[:alert] = params[:alert] ||= nil  #take care of bad account from above redirect
    end
    return current_account
  end

  def check_my_account(account)
    if account != current_account.name
      redirect_to "/opps" , :alert => "Sorry, resource is not part of your account"
    end
  end

  def require_user
    unless current_user
      flash[:notice] = "You must be logged in to access this page"
      redirect_to root_url
      return false
    end
  end

    rescue_from CanCan::AccessDenied do |exception|
      flash[:alert] = exception.message
      redirect_to "/opps"
    end


  def after_sign_in_path_for(resource_or_scope)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    account_name = current_user.account.name
    if current_account.nil?
      # logout of root domain and login by token to account
      token =  Devise.friendly_token
      current_user.loginable_token = token
      current_user.save
      sign_out(current_user)
      flash[:notice] = nil
      home_path = valid_user_url(token, :account => account_name)
      return home_path
    else
      if account_name != current_account.name
        # user not part of current_account
        sign_out(current_user)
        flash[:notice] = nil
        flash[:alert] = "Sorry, invalid user or password for account"
      end
    end
    super
  end

end

