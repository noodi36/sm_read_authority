class FriendController < ApplicationController

    skip_before_filter  :verify_authenticity_token
    before_action :authenticate_user!

    def myfriend
        @friends = current_user.friends
    end
    
    def search
        @all_users = User.all
    end
    
    def result
        @all_users = User.search(params[:search]).reverse
    end
    
    def f_request
        
        @adding = params[:adding]
        
        if @adding == "친구추가"
            @friend = User.find_by_nickname(params[:nickname])
            current_user.friend_request(@friend)
        elsif @adding == "요청받음"
           
            if params[:yesOrno] == "수락"
                @accept = User.find_by_nickname(params[:nickname])
                current_user.accept_request(@accept)
            
            elsif params[:yesOrno] == "거절"
                @decline = User.find_by_nickname(params[:nickname])
                current_user.decline_request(@decline)
            end
        else
        end
        
        redirect_to :back
    end
end