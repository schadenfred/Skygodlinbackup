class MembersController < ApplicationController
  # GET /members
  # GET /members.xml
  before_filter :require_user
  before_filter :new
  load_and_authorize_resource
  before_filter :test
  def index
    @members = Member.where(:account_id => current_user.account_id)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @members }
    end
  end

  # GET /members/1
  # GET /members/1.xml
  def show
    #@member = Member.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @member }
    end
  end

  # GET /members/new
  # GET /members/new.xml
  def new
    #new is not valid route, if id = new, redirect
    if params[:id] == "new"
      redirect_to :members, :alert => "New action on members disabled, use invite"
    end
  end

  # GET /members/1/edit
  def edit
    #@member = Member.find(params[:id])
  end


  # PUT /members/1
  # PUT /members/1.xml
  def update
    #@member = Member.find(params[:id])

    respond_to do |format|
      if @member.update_attributes(params[:member])
        format.html { redirect_to(@member, :notice => 'Member was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @member.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.xml
  def destroy
    #@member = Member.find(params[:id])
    @member.destroy

    respond_to do |format|
      format.html { redirect_to(members_url) }
      format.xml  { head :ok }
    end
  end
  
  def test
    if @member
      check_my_account(@member.account.name)
    end
  end
end
