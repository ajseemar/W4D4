class BandsController < ApplicationController

    def index
        @bands = Band.all
    end

    def new
        @band = Band.new
    end

    def create
        @band = Band.new(band_params)
        if @band.save
            redirect_to band_url(@band)
        else
            flash[:empty] = @band.errors.full_messages
            redirect_to new_band_url
        end
    end

    def show
        @band = Band.find(params[:id])
    end

    def edit

    end

    def update

    end

    def destroy

    end

    private

    def band_params
        params.require(:band).permit(:name)
    end
end
