class Api::V1::SubscribersController < Api::ApplicationController
  #skip_before_action :authenticate_user!

  def index
    @subscribers = Subscriber.all
    render json: @subscribers
  end

  def create
    @subscriber = Subscriber.new(subscriber_params)
    if @subscriber.save
      render json: @subscriber, status: :created
    else
      render json: @subscriber.errors, status: :unprocessable_entity
    end
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:name, :email)
  end
end
