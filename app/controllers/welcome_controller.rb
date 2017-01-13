class WelcomeController < ApplicationController
  def index
    flash[:notice] = "欢迎来到职缺世界，总有一个适合你！"
  end
end
