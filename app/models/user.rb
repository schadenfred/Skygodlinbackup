class User < ActiveRecord::Base
  belongs_to :account
  
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :name
  validates_presence_of :account_name, :on => :create, :message => "Account name must be unique and not blank" 
  validates_uniqueness_of  :email, :case_sensitive => false
  attr_accessor :account_name  # used to create a account
  attr_accessible :name, :account_name, :account_id, :email, :password, :password_confirmation, :loginable_token, :login, :roles
  before_validation :create_account, :on => :create
  after_create :update_account_owner
  before_create :create_login
  
  def self.valid?(params)
    token_user = self.where(:loginable_token => params[:id]).first
    if token_user
      token_user.loginable_token = nil
      token_user.save
    end
    return token_user
  end
  
  def self.find_for_database_authentication(conditions)
    self.where(:login => conditions[:email]).first || self.where(:email => conditions[:email]).first
  end
  
  private

  def create_account
    # create an account on creating a new user
    # if the account does not exist - sign_up only
    # sets up for validate_presence of account_name to fail if blank or not unique
    if self.account_name.blank?
      return
    end
    acct = Account.find_by_name(self.account_name) 
    if acct.nil? 
      self.account = Account.create!(:name => self.account_name)
    else
      self.account_name = ""
    end
  end

  def update_account_owner
    # set owner of account to user that created it
    account = self.account
    if account && account.user_id.nil?
      account.user_id = self.id
      account.save
      self.roles = "site_admin"
      self.save
    end
  end
  
  def create_login             
    email = self.email.split(/@/)
    login_taken = User.where( :login => email[0]).first
    unless login_taken
      self.login = email[0]
    else	
      self.login = self.email
    end	       
  end
  
end


