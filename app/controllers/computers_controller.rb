class ComputersController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :check]
  before_action :set_computer, only: [:show, :edit, :update, :destroy, :key]
  authorize_resource except: [:index, :check]

  # GET /computers
  # GET /computers.json
  def index
    if signed_in?
      @computers = current_user.computers.all.decorate
      @computer = current_user.computers.new
    end
  end

  # GET /computers/1
  # GET /computers/1.json
  def show
  end

  # GET /computers/new
  def new
    @computer = current_user.computers.new
  end

  # GET /computers/1/edit
  def edit
  end

  def key
    send_data render_to_string, :disposition => 'attachment'
  end

  def check
    begin
      @computer = Computer.where(key: params[:key]).first
      if @computer
        @computer.track! request.env['HTTP_X_REAL_IP'] || request.remote_ip

        render text: @computer.user.key, content_type: "text/plain"
      else
        render text: '', status: 404
      end

    rescue Mongoid::Errors::DocumentNotFound
      render text: '', status: 404
    end
  end

  # POST /computers
  # POST /computers.json
  def create
    @computer = current_user.computers.new(computer_params)

    respond_to do |format|
      if @computer.save
        current_user.add_role :owner, @computer
        format.html { redirect_to computers_path, notice: t('computer.created') }
        format.json { render action: 'show', status: :created, location: @computer }
      else
        format.html { render action: 'new' }
        format.json { render json: @computer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /computers/1
  # PATCH/PUT /computers/1.json
  def update
    respond_to do |format|
      @computer.versionless do |doc|
        if doc.update(computer_params)
          format.html { redirect_to computers_path, notice: t('computer.updated') }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @computer.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /computers/1
  # DELETE /computers/1.json
  def destroy
    @computer.destroy
    respond_to do |format|
      format.html { redirect_to computers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_computer
      @computer = Computer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def computer_params
      params.require(:computer).permit(:name)
    end
end
