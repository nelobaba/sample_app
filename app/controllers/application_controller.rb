class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    def hello
        render html: "Hello, Nelson Umunna Welcome to Zetatango!"
    end
end
