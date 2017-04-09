class AdminController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  before_action :require_is_admin
end
