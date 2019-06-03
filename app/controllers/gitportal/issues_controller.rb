class Gitportal::IssuesController < ApplicationController
  before_action :set_back_link

  def index
    @labels = GithubService.new.labels
    @issues = GithubService.new.issues
    @hours = get_hours(@issues)
    @issues = @issues.reverse!
    if params[:sort] == 'alph'
      @issues = @issues.sort_by { |hsh| hsh['title'] }
    end
    filter_by_label
    pending_billing
  end

  def show
    @issue = GithubService.new.issue(params[:id])
  end

  private

  def get_hours(issues)
    titles = issues.map{|x| x['title']}
    array_of_hours = titles.to_sentence.scan(/\[(.*?)\]/)
    clean_non_numbers = array_of_hours.map {|i| i[0].to_i}
    estimated_hours = clean_non_numbers.sum
    rescue
      'Unknown'
  end

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

  def pending_billing
    if params[:pending_billing]
      @issues = GithubService.new.closed_isssues_by_label_id('💰 To be invoiced')
    end
  end

  def set_back_link
    if params[:milestone_number].present?
      @back_link_title = "Milestone ##{params[:milestone_number]}"
      @back_link = gitportal.milestone_path(params[:milestone_number])
    else
      @back_link_title = "Pipeline"
      @back_link = gitportal.issues_path
    end
  end

end
