class Cms::Fortress::UsersController < Comfy::Admin::Cms::BaseController
  before_action do
    authorize! :manage, Cms::Fortress::User
  end
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /cms/fortress/users
  # GET /cms/fortress/users.json
  def index
    # @cms_fortress_users = Cms::Fortress::User.all
    @cms_fortress_users = @site.users
  end

  # GET /cms/fortress/users/1
  # GET /cms/fortress/users/1.json
  def show
  end

  # GET /cms/fortress/users/new
  # GET /cms/fortress/users/new.json
  def new
    @cms_fortress_user = @site.users.build
  end

  # GET /cms/fortress/users/1/edit
  def edit
  end

  # POST /cms/fortress/users
  # POST /cms/fortress/users.json
  def create
    @cms_fortress_user = @site.users.build(user_params.merge(type_id: 2))

    respond_to do |format|
      if @cms_fortress_user.save
        flash[:success] = "User was successfully created."
        format.html { redirect_to cms_fortress_users_path }
        format.json { render json: @cms_fortress_user, status: :created, location: @cms_fortress_user }
      else
        format.html { render action: "new" }
        format.json { render json: @cms_fortress_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cms/fortress/users/1
  # PUT /cms/fortress/users/1.json
  def update
    user = user_params
    if user[:password].blank?
      user.delete(:password)
      user.delete(:password_confirmation) if user[:password_confirmation].blank?
    end
    user[:type_id] = 2

    respond_to do |format|
      if @cms_fortress_user.update_attributes(user)
        flash[:success] = "User was successfully updated."
        format.html { redirect_to cms_fortress_users_path }
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
      format.html { redirect_to cms_fortress_users_url }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @cms_fortress_user = @site.users.where(id: params[:id]).first
  end

  def user_params
    params.require(:cms_fortress_user).permit(:last_name, :first_name, :email, :role_id, :password, :password_confirmation)
  end
end
