class ServersController < ApplicationController
  before_action :set_server, only: [:show, :edit, :update, :destroy]

  # GET /servers
  # GET /servers.json
  def index
    @servers = Server.all
  end

  # GET /servers/1
  # GET /servers/1.json
  def show
    ldap = Net::LDAP.new
    @user = @server.users.all#(user_params)
   
  end

  # GET /servers/new
  def new
    @server = Server.new
    @user = User.new
  end

  # GET /servers/1/edit
  def edit
  end

  # POST /servers
  # POST /servers.json
  def create
    @user = User.new#(user_params)
    @server = Server.new(server_params)
    @server.dig
        ldap = Net::LDAP.new
    ldap.host = @server.host
    ldap.port = 389
    ldap.auth @server.login+"@#{@server.domain}", @server.pass
    treebase = @server.domain.split('.').map {|d| "dc=#{d}" }.join(',')
    filter = Net::LDAP::Filter.eq( "objectclass", "person" )
    ldap.search( :base => treebase, :filter => filter ) do |entry|
      
      @user = @server.users.new#(user_params)
      @user.accountname = entry.sAMAccountName.join
      @user.cn = entry.cn.join
      @user.objectclass = entry.objectclass
      @user.dn = entry.dn
      # @user.created_at = Time.now
      # @user.updated_at = @user.created_at unless @user.updated_at
      @user.save
    end


    respond_to do |format|
      if @server.save
        format.html { redirect_to @server, notice: 'Server was successfully created.' }
        format.json { render :show, status: :created, location: @server }
      else
        format.html { render :new }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /servers/1
  # PATCH/PUT /servers/1.json
  def update
    respond_to do |format|
      if @server.update(server_params)
        format.html { redirect_to @server, notice: 'Server was successfully updated.' }
        format.json { render :show, status: :ok, location: @server }
      else
        format.html { render :edit }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /servers/1
  # DELETE /servers/1.json
  def destroy
    @server.destroy
    respond_to do |format|
      format.html { redirect_to servers_url, notice: 'Server was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # def set_user
  #   @user = User.find(params[:id])
  # end

  # def user_params
  #   params.require(:user).permit(:accountname, :cn, :objectclass, :dn, :server)
  # end

    # Use callbacks to share common setup or constraints between actions.
    def set_server
      @server = Server.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def server_params
      params.require(:server).permit(:login, :pass, :domain, :host)
    end
end
