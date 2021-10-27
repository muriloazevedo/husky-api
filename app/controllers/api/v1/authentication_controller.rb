module Api
  module V1
    class AuthenticationController < ApplicationController
      def create
        user = User.find_or_create_by!(email: params[:user][:email])

        token = Auth::SendMagicLink.new(user).call
 
        return head :ok if token

        head :bad_request
      end
    end
  end
end
