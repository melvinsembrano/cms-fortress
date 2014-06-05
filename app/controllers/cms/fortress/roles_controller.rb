class Cms::Fortress::RolesController < Comfy::Admin::Cms::BaseController
  before_filter do
    authorize! :manage, Cms::Fortress::Role
  end
  before_action :set_role, only: [:show, :edit, :update, :destroy, :refresh]

  # GET /cms/fortress/roles
  # GET /cms/fortress/roles.json
  def index
    @cms_fortress_roles = @site.roles
  end

  # GET /cms/fortress/roles/1
  # GET /cms/fortress/roles/1.json
  def show
    @no_back_button = true
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cms_fortress_role }
    end
  end

  def refresh
    # @cms_fortress_role = Cms::Fortress::Role.find(params[:id])
    @cms_fortress_role.load_defaults

    respond_to do |format|
      if @cms_fortress_role.save
        format.html { redirect_to @cms_fortress_role }
        format.json { render json: @cms_fotress_role }
      else
        format.html { render action: "show" }
        format.json { render json: @cms_fortress_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /cms/fortress/roles/new
  # GET /cms/fortress/roles/new.json
  def new
    @cms_fortress_role = @site.roles.build
  end

  # GET /cms/fortress/roles/1/edit
  def edit
  end

  # POST /cms/fortress/roles
  # POST /cms/fortress/roles.json
  def create
    @cms_fortress_role = @site.roles.build(role_params)
    begin
      @cms_fortress_role.load_defaults
    rescue Cms::Fortress::Error::MissingRoleConfigurationFile
      flash[:error] = @cms_fortress_role.errors.messages[:base].first
      render action: "new" and return
    end

    respond_to do |format|
      if @cms_fortress_role.save
        flash[:success] = "Role was successfully created."
        format.html { redirect_to @cms_fortress_role }
        format.json { render json: @cms_fortress_role, status: :created, location: @cms_fortress_role }
      else
        format.html { render action: "new" }
        format.json { render json: @cms_fortress_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cms/fortress/roles/1
  # PUT /cms/fortress/roles/1.json
  def update
    respond_to do |format|
      if @cms_fortress_role.update_attributes(role_params)
        flash[:success] = "Role was successfully updated."
        format.html { redirect_to @cms_fortress_role }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cms_fortress_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cms/fortress/roles/1
  # DELETE /cms/fortress/roles/1.json
  def destroy
    @cms_fortress_role.destroy

    respond_to do |format|
      format.html { redirect_to cms_fortress_roles_url }
      format.json { head :no_content }
    end
  end

  private

  def set_role
    @cms_fortress_role = @site.roles.where(id: params[:id]).first
  end

  def role_params
    params.require(:cms_fortress_role).permit! #(:name, :description, :role_details_attributes)
  end
end
