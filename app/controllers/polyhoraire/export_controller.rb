require 'polyhoraire'

class Polyhoraire::ExportController < ApplicationController
  before_filter :polyFetch

  def initialize
    @exporters = {
      'google' => 'Google Calendar'  
    }
  end  
  
  private 
  
  def polyFetch
    @auth = Poly::Auth.new
    @auth.connect(session[:user],session[:password],session[:bday])
  end
end
