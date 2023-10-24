require 'bcrypt'

class TopController < ApplicationController
    def main
        if session[:login_uid] != nil
            render "main"
        else
            render "login"
        end
    end

    def login
        user = User.find_by(uid: params[:uid])
        login_password = BCrypt::Password.new(user.pass)
        if login_password == params[:pass]
            session[:login_uid] = params[:uid]
            redirect_to top_main_path
        else
            render "error"
        end
    end
    
    def logout
        session[:login_uid] = nil
        render "login"
    end
end
