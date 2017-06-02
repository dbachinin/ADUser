class UserShowEditController < ApplicationController
  def new
    @user = @server.users.new
  end

  def show
    @user = User.find(params[:id])
    server = Server.find(@user.server_id)
    ldap = Net::LDAP.new
    ldap.host = server.host
    ldap.port = 389
    ldap.auth server.login+"@#{server.domain}", server.pass
    treebase = server.domain.split('.').map {|d| "dc=#{d}" }.join(',')
    filter = Net::LDAP::Filter.eq( "samaccountname", @user.accountname )
    ldap.search( :base => treebase, :filter => filter ) do |entry|
      @showuser = entry
      @key
      @val = @user.id
    end
  end

  def create
  end
  
  def edit
      @key
      @val = User.find(params[:id])

  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:accountname, :cn, :objectclass, :dn, :server)
  end
end
