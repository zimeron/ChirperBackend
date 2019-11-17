# Handles CRUD requests for Chirper posts
class PostsController < ApplicationController
    # Finds all the posts a given user (specified by id param) is allowed to see
    # This includes all their own posts, as well as all the posts of their followed users
    # Sorts latest 20 posts by date and returns them as JSON to the Post frontend type.
    def show
        puts "Retrieving and sorting posts"
        # Check if user following is null
        @following = []
        if User.find(params[:id]).following != nil
            @following = User.find(params[:id]).following
        end
        # Add session user to query array
        @following.push(params[:id])
        # Query based on array of ids
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

    # Creates a new post in the DB from data in a POST request
    def create
        puts "Trying to Create New Post"
        # Creates new post with given content tied to given userid
        @post = Post.new(post_params)        
        if @post.save
            puts "Post successfully created"
            response.status=(201)
            render json: {status: "Success",  message: ["Post created!"]}
        else
            # Error handling
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
