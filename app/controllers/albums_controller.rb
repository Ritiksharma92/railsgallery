class AlbumsController < ApplicationController
        
        def index
          # @albums= Album.all
          @q = Album.ransack(params[:q])
          @albums = @q.result.includes(:tags, :taggings)
        end
      
        def show
          @album = Album.find(params[:id])
        end
      
        def new
          @album = current_user.albums.new
        end
      
        def create
          @album = current_user.albums.new(album_params)
        
          if @album.save
            redirect_to 'albums/index'
          else
            render :new
          end
        end
      
      def edit
        @album = Album.find(params[:id])
      end
      
      def update
        @album = Album.find(params[:id])
      
        if @album.update(album_params)
          redirect_to @album
        else
          render :edit
        end
      end
      
      def destroy
        @album = Album.find(params[:id])
        @album.destroy
        redirect_to root_path
      end

      def delete_image_attachment
        @image = ActiveStorage::Blob.find_signed(params[:id])
        @image.attachments.first.purge
        redirect_to albums_url
      end
      
      private
      def album_params
        params.require(:album).permit(:album_name, :cover_picture, :delete_image_attachment,:created_by, :description, :published, :all_tags,images: [] )
      end

end
