require 'polyhoraire/auth'
require 'polyhoraire/schedule'
require 'google_exporter'

class PolyhoraireController < ApplicationController
  
  def index
    
  end
  
  def connect
    
    auth = Poly::Auth.new
    begin
      auth.connect(params[:user],params[:password],params[:bday])
      session[:user] = params[:user]
      session[:password] = params[:password]
      session[:bday] = params[:bday]
      session[:trimesters] = auth.trimesters
      
      redirect_to :action => :trimester
    rescue
      redirect_to :action => :index
    end
  end
  
  def trimester
    trimesters = session[:trimesters]
  end
  
  def calendar
    session[:trimester] = params[:trimester]
    
    exporter = GoogleExporter.new
    exporter.auth_web(params[:code],session[:token_id]) do |haveAccess,token_id|
      session[:token_id] = token_id
      redirect_to exporter.client.authorization.authorization_uri.to_s unless haveAccess
    end
    
    #flash[:client] = exporter.client
    @calendarList = Hash.new# exporter.calendarList
    @calendarList[:bob] = 'asas'
  end
  
  def googleOAuthCallback
    exporter = GoogleExporter.new
    exporter.auth_web(params[:code],session[:token_id]) do |code,tokenID,client,haveAccess|
      client.authorization.fetch_access_token!
      # Persist the token here
      token_pair = if session[:token_id]
        TokenPair.get(session[:token_id])
      else
        TokenPair.new
      end
      token_pair.update_token!(client.authorization)
      token_pair.save
      session[:token_id] = token_pair.id
      redirect_to :action => :export 
    end
    
  end
=begin
  def export
    exporter = GoogleExporter.new
    
    auth = Poly::Auth.new
      
    user      = session[:user]
    password  = session[:password]
    bday      = session[:bday]
    trimester = params[:trimester]
    
    auth.connect(user,password,bday)
    
    schedule = Poly::Schedule.new(auth,trimester)
    exporter.send(@schedule,'ekd38fnk731clljnj56svvvdgk@group.calendar.google.com')
  end
=end
  def results
  end
  
  private 
  def googleAuth
    
  end

end
