class AlbumsController < ApplicationController
    
    def new
        @album = Album.new
    end

    def create
        album = Album.new(album_params)
        if album.save
            redirect_to album_url(album)
        else
            flash[:errors] = album.errors.full_messages
            redirect_to new_album_url
        end
    end

    def show
        @album = Album.find(params[:id])
    end

    def edit

    end

    def update

    end

    def destroy

    end

    private

    def album_params
        params.require(:album).permit(:band_id, :title, :year, :is_live)
    end

end
