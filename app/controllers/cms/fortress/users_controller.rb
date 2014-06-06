class Cms::Fortress::UsersController < Comfy::Admin::Cms::BaseController
  before_action do
    authorize! :manage, Cms::Fortress::User
  end
  before_action :set_user, :valid_super, only: [:show, :edit, :update, :destroy]
  before_action :check_super, only: [:super, :new_super]

  # GET /cms/fortress/users
  # GET /cms/fortress/users.json
  def index
    @super_user = false
    @cms_fortress_users = @site.users
  end

  def super
    @super_user = true
    @cms_fortress_users = Cms::Fortress::User.all_super
    render action: :index
  end

  # GET /cms/fortress/users/1
  # GET /cms/fortress/users/1.json
  def show
  end

  # GET /cms/fortress/users/new
  # GET /cms/fortress/users/new.json
  def new
    @super_user = false
    @cms_fortress_user = @site.users.build(type_id: 2)
  end

  def new_super
    @super_user = true
    @cms_fortress_user = Cms::Fortress::User.new(type_id: 1)
    render action: :new
  end

  # GET /cms/fortress/users/1/edit
  def edit
  end

  # POST /cms/fortress/users
  # POST /cms/fortress/users.json
  def create
    @cms_fortress_user = @site.users.build(user_params)
    raise CanCan::AccessDenied.new("Your are not allowed to create a super user.") if @cms_fortress_user.type.eql?(:super_user) && !current_cms_fortress_user.type.eql?(:super_user)
    @cms_fortress_user.site_id = nil if @cms_fortress_user.type.eql?(:super_user)

    if @cms_fortress_user.save
      flash[:success] = "User was successfully created."
      respond_to do |format|
        format.html { redirect_to @cms_fortress_user.type.eql?(:super_user) ? super_cms_fortress_users_path : cms_fortress_users_path }
        format.json { render json: @cms_fortress_user, status: :created, location: @cms_fortress_user }
      end
    else
      respond_to do |format|
        format.html { render action: "new" }
        format.json { render json: @cms_fortress_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cms/fortress/users/1
  # PUT /cms/fortress/users/1.json
  def update
    user = user_params

    raise CanCan::AccessDenied.new("Your are not allowed to create a super user.") if user[:type_id].eql?(1) && !current_cms_fortress_user.type.eql?(:super_user)

    if user[:password].blank?
      user.delete(:password)
      user.delete(:password_confirmation) if user[:password_confirmation].blank?
    end

    respond_to do |format|
      if @cms_fortress_user.update_attributes(user)
        flash[:success] = "User was successfully updated."
        format.html { redirect_to @cms_fortress_user.type.eql?(:super_user) ? super_cms_fortress_users_path : cms_fortress_users_path }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cms_fortress_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cms/fortress/users/1
  # DELETE /cms/fortress/users/1.json
  def destroy
    @cms_fortress_user.destroy

    respond_to do |format|
      format.html { redirect_to @cms_fortress_user.type.eql?(:super_user) ? super_cms_fortress_users_path : cms_fortress_users_path }
      format.json { head :no_content }
    end
  end

  private

  def valid_super
    raise CanCan::AccessDenied.new("Your are not authorised to execute this process.") if @cms_fortress_user.type.eql?(:super_user) && !current_cms_fortress_user.type.eql?(:super_user)
    @super_user = @cms_fortress_user.type.eql?(:super_user)
  end

  def check_super
    raise CanCan::AccessDenied.new("Your are not authorised to execute this process.") unless current_cms_fortress_user.type.eql?(:super_user)
    # @super_user = current_cms_fortress_user.type.eql?(:super_user)
  end

  def set_user
    @cms_fortress_user = Cms::Fortress::User.find(params[:id]) # @site.users.where(id: params[:id]).first
  end

  def user_params
    params.require(:cms_fortress_user).permit(:last_name, :first_name, :email, :type_id, :role_id, :password, :password_confirmation)
  end
end
