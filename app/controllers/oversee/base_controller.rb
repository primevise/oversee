module Oversee
  class BaseController < ActionController::Base
    include Pagy::Backend
    layout "oversee/application"
  end
end