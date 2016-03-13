class Users::SearchController < ApplicationController

  def index
    respond_to do |format|
      format.json { render json: users.to_json }
    end
  end

  private

  def users
    User.search(params[:query].to_s)
  end

end
