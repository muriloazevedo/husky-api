module Api
  module V1
    class AuthenticationController < ApplicationController
      def create
        user = User.find_or_create_by!(email: params[:user][:email])
    
        user.send_magic_link
    
        head :ok
      end
    end
  end
end
