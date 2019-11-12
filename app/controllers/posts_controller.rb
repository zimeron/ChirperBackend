class PostsController < ApplicationController
    def show
        puts "Retrieving and sorting posts"
        @following = []
        if User.find(params[:id]).following != nil
            @following = User.find(params[:id]).following
        end
        @following.push(params[:id])
        @posts = []
        Post.where(userid: @following)
            .order(created_at: :desc)
            .find_each(:batch_size => 20) do |post|
            @posts.push(post)
        end
        render json: @posts.to_json
    end

    def index
        
    end

    def create
        puts "Trying to Create New Post"
        @post = Post.new(post_params)        
        if @post.save
            puts "Post successfully created"
            response.status=(201)
            render json: {status: "Success",  message: ["Post created!"]}
        else
            puts "Something went wrong while creating new Post"
            puts(@Post.errors.full_messages)
            response.status=(422)
            render json: { status: "Error", message: [@post.errors.full_messages]}
        end
    end

    def post_params
        params.permit(:content, :userid, :username)
    end
end
