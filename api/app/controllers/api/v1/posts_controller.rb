module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_post, only: [:show, :update, :destroy]

      def index
        posts = if search_query.present?
                  Post.es_search(search_query).first
                else
                  Post.all
                end
        puts posts.inspect
        serializer = PostSerializer.new(posts).serialized_json
        render json: serializer
      end

      def create
        post = Post.new(post_params)
        if post.save
          render json: serializer = PostSerializer.new(posts).serialized_json
        else
          render json: { status: 'ERROR', data: post.errors }
        end
      end

      def show
        render json: @post, serializer: PostSerializer
      end

      def update
        if @post.update(post_params)
          render json: @post, serializer: PostSerializer
        else
          render json: @post, serializer: PostSerializer
        end
      end

      def destroy
        @post.destroy
        render json: @post, serializer: PostSerializer
      end

      private
      def set_post
        @post = Post.find(params[:id])
      end

      def search_query
        @search_query ||= params[:search_query].to_s
      end

      def post_params
        params.require(:post).permit(:id, :title, :body)
      end
    end
  end
end
