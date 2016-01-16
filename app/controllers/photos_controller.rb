class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  # GET /photos
  # GET /photos.json
  def index
    #@photos = Photo.all
    #@photos_user = PhotosUser.where("user_id = ? AND is_owner = ? ", session[:user_id], 1)
    @my_photos = Photo.joins(:photos_users).where(photos_users: {user_id: session[:user_id], is_owner: 1} )
    
    @shared_photos = Photo.joins(:photos_users).where(photos_users: {user_id: session[:user_id], is_owner: nil} )
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
    @photo.photos_users.build
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)

    respond_to do |format|
      if @photo.save
        #Make entry for all shared users.
        shared_users = params[:users]
        #looping through all the users, and trimming the beginning and trailing spaces 
        shared_users.split(",").map(&:strip).each do |uname|
          #make an entry in the users if user doesn't exist
          @uname_obj = User.find_or_create_by!(username: uname)

          #make an entry in the mapping table
          PhotosUser.find_or_create_by!(user_id: @uname_obj.id, photo_id: @photo.id)
        end

        format.html { redirect_to photos_path, notice: 'Message was successfully Shared.' }
        format.json { render :index, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like_photo
    @user.photos_users.where(:photo_id => params[:photo_id]).first.update_attributes(liked: true)
  end

  def comment
    @user.photos_users.where(:photo_id => params[:photo_id]).first.update_attributes(comment: params[:comment])
  end

  def view_comments
    @users_comments = PhotosUser.where(:photo_id => params[:photo_id]).all;
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end
    
    def set_user
      #get current user from session
      @user = User.find(session[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:users, :file_name, :file_path, :photos_users_attributes => [:user_id, :photo_id, :is_owner])
    end

end
