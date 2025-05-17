class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  rescue_from HTTParty::Error, with: :search_error_redirect

  private

  def search_error_redirect(_)
    redirect_to forecasts_path, flash: { alert: "Please enter a valid address." }
  end
end
