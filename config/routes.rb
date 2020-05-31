Rails.application.routes.draw do

  get("/text", { :controller => "vision", :action => "a_text" })
  post("/process_text", { :controller => "vision", :action => "process_text" })

  get("/web", { :controller => "vision", :action => "a_web" })
  post("/process_web", { :controller => "vision", :action => "process_web" })

  # =============================

  root("vision#homepage")

  get("/vision/:detector", { :controller => "vision", :action => "form" })
  post("/vision/:detector", { :controller => "vision", :action => "magic" })

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
