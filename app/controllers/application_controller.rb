class ApplicationController < ActionController::Base
  before_action :set_site

  private

  def set_site
    @site_title = "Blog to Remind"
  end

  def auth
    authenticate_or_request_with_http_basic do |user, pass|
      user == 'kimiyosi3' && pass == 'FF4seshiru!'
    end
  end

end
