class ApplicationController < ActionController::Base

  skip_before_action :verify_authenticity_token
  def hello
    render html: "Hello World!"
  end
end
