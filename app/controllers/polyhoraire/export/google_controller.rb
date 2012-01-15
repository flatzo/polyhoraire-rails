require 'data_mapper'
require 'google_exporter'


class Polyhoraire::Export::GoogleController < ApplicationController
  Poly::userConfDir = 'config'
  before_filter :auth
  
  def calendars
    @calendarList = @exporter.calendarList
  end
  
  def oauth2callback
    session[:tokenID] = @exporter.authWebCallback(session[:tokenID])
    redirect_to :action => :calendars
  end
  
  private
  
  def auth
    @exporter = GoogleExporter.new
    callBackURI = url_for :action => :oauth2callback
    
    
    accessToken = @exporter.authWeb(params[:code],session[:tokenID],callBackURI)
    redirect_to @exporter.authURI unless accessToken || params[:action] == 'oauth2callback'
  end
end
