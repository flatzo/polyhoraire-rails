#encoding: UTF-8

require 'data_mapper'
require 'polyhoraire'
require 'google_exporter'


class Polyhoraire::Export::GoogleController < ApplicationController
  Poly::userConfDir = 'config'
  before_filter :auth
  
  def export
    redirect_to :action => :calendars
  end
  
  def index
    redirect_to :action => :calendars
  end
  
  def pushto
    auth = Poly::Auth.new
    auth.connect(session[:user],session[:password],session[:bday])
    
    schedule = Poly::Schedule.new(auth,session[:trimester].to_i)
    
    begin
      @exporter.send(schedule,params[:calendarID])
    rescue ClientError
      @error = 'Problème du côté du serveur'
    rescue ServerError
      @error = 'Problème du côté de google'
    rescue TransmissionError
      @error = 'Problème de transmission des données'
    end
    
  end
  
  def calendars
    @calendarList = @exporter.calendarList
    puts @calendarList
  end
  
  def oauth2callback
    session[:tokenID] = @exporter.authWebCallback(session[:tokenID])
    redirect_to :action => :calendars
  end
  
  private
  
  def auth
    session[:trimester] = params[:trimester] if params[:trimester]
    @exporter = GoogleExporter.new
    callBackURI = url_for :action => :oauth2callback, :id => nil
    
    
    accessToken = @exporter.authWeb(params[:code],session[:tokenID],callBackURI)
    unless accessToken || params[:action] == 'oauth2callback'
      flash[:trimester] = params[:trimester]
      redirect_to @exporter.authURI
    end
  end
end
