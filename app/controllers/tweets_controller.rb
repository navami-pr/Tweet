class TweetsController < ApplicationController

	before_action :authenticate_request

	before_action :validate_access, only: [:update, :destroy]

	def index
    @tweets = Tweet.all
    render json: { tweets: @tweets ,status: :ok}
  end

  def show
    @tweet = Tweet.find_by(id: params[:id])
    if @tweet
    	render json: { tweet: @tweet ,status: :ok}
    else
     	render json: {status: 203,message: 'Tweet not Present'}
    end
  end

  def create
  	if tweet_params[:comment]
	    @tweet = current_user.tweets.create!(tweet_params)
	    render json: { tweet: @tweet ,status: :created}
	  else
	  	render json: {status: 203,message: 'Empty tweet'}
	  end
  end

  def update
    if @authorised_user
    	@tweet = Tweet.find_by(id: params[:id])
    	@tweet.update_attributes(tweet_params)
    	@tweet.save
    	render json: { tweet: @tweet ,status: :ok, update_by: current_user.name}
    else
     	render json: {status: 401,messae: 'You are not authorised !!!'}
    end
  end

  def destroy
    if @authorised_user
			@tweet = Tweet.find_by(id: params[:id])
    	@tweet.update_attributes(tweet_params)
    	@tweet.delete
    	render json: { tweet: @tweet ,status: :ok, messae: 'Deleted successfully!!'}
    else
     	render json: {status: 401,messae: 'You are not authorised !!!'}
    end
  end

  private

  def validate_access
  	if current_user.is_admin
  		@authorised_user = true
  	else
  		@authorised_user = current_user.tweets.where(id: params[:id]).present? ? true : false
  	end
  end

  def tweet_params
    params.permit(:comment)
  end
end
