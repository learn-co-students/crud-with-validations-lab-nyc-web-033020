class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def new
    @song = Song.new
    render 'new'
  end

  def show
    @song = Song.find(params[:id])
    render 'show'
  end

  def edit
    @song = Song.find(params[:id])
    render 'edit'
  end

  def update
    song = Song.find(params[:id])
    song.assign_attributes(song_params)
    if song.valid?
      song.save
      redirect_to song_path(song)
    else
      render 'edit'
    end
  end

  def create
    @song = Song.new(song_params)
    if @song.valid?
      @song.save
      redirect_to song_path(@song)
    else
      flash[:errors] = @song.errors.full_messages
      render 'new'
    end
  end 

  def destroy
    song = Song.find(params[:id])
    song.destroy
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :released, :release_year, :artist_name, :genre)
  end
end
