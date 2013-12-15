class Cms::Fortress::RolesController < Admin::Cms::BaseController
  before_filter do
    authorize! :manage, Cms::Fortress::Role
  end


  # GET /cms/fortress/roles
  # GET /cms/fortress/roles.json
  def index
    @cms_fortress_roles = Cms::Fortress::Role.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cms_fortress_roles }
    end
  end

  # GET /cms/fortress/roles/1
  # GET /cms/fortress/roles/1.json
  def show
    @cms_fortress_role = Cms::Fortress::Role.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cms_fortress_role }
    end
  end

  def refresh
    @cms_fortress_role = Cms::Fortress::Role.find(params[:id])
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
    @cms_fortress_role = Cms::Fortress::Role.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cms_fortress_role }
    end
  end

  # GET /cms/fortress/roles/1/edit
  def edit
    @cms_fortress_role = Cms::Fortress::Role.find(params[:id])
  end

  # POST /cms/fortress/roles
  # POST /cms/fortress/roles.json
  def create
    @cms_fortress_role = Cms::Fortress::Role.new(role_params)
    @cms_fortress_role.load_defaults

    respond_to do |format|
      if @cms_fortress_role.save

        format.html { redirect_to @cms_fortress_role, notice: 'Role was successfully created.' }
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
    @cms_fortress_role = Cms::Fortress::Role.find(params[:id])

    respond_to do |format|
      if @cms_fortress_role.update_attributes(role_params)
        format.html { redirect_to @cms_fortress_role, notice: 'Role was successfully updated.' }
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
    @cms_fortress_role = Cms::Fortress::Role.find(params[:id])
    @cms_fortress_role.destroy

    respond_to do |format|
      format.html { redirect_to cms_fortress_roles_url }
      format.json { head :no_content }
    end
  end

  private

  def role_params
    params.require(:cms_fortress_role).permit! #(:name, :description, :role_details_attributes)
  end
end
