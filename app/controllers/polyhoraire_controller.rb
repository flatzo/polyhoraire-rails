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
      
      redirect_to :action => :trimesters
    rescue
      redirect_to :action => :index
    end
  end
  
  def trimesters
    
    auth = Poly::Auth.new
    begin
      auth.connect(session[:user],session[:password],session[:bday])
    rescue
      redirect_to :action => :index
    end
    
    @trimesters = auth.trimesters
  end
  
  
  private 

end
