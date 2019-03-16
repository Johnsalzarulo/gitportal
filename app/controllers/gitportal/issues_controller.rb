class Gitportal::IssuesController < ApplicationController

  def index
    @labels = GithubService.new.labels
    @issues = GithubService.new.issues.reverse!
    filter_by_label
  end

  private

  def filter_by_label
     return return_from_session_label unless params[:label].present?
     @label = params[:label]
     update_sesssion_label(params[:label])
     @issues = GithubService.new.isssues_by_label_id(@label)
     @issues = @issues.reverse!
   end

   def update_sesssion_label(label)
     session[:label] = label
   end

   def return_from_session_label
     return clear_label if params[:clear].present?
     return false unless session[:label].present?
     @label = session[:label]
     @issues = GithubService.new.isssues_by_label_id(@label)
   end

   def clear_label
     session[:label] = nil
   end


end
