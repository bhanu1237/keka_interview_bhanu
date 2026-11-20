class ApplicationController < ActionController::API
    def sample
        render json: {}, status: :ok
    end
end
