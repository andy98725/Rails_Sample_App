class ApplicationController < ActionController::Base
  def hello
      render html: "Jello World!!"
  end
end
