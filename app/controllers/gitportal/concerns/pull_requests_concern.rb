module Gitportal::Concerns::PullRequestsConcern
  extend ActiveSupport::Concern

  def index
    @changes = GithubService.new.pull_requests
    @changes = @changes.sort_by { |hsh| hsh['merged_at'] || '0' }.reverse!
  end

  def show
    @change = GithubService.new.issue(params[:id])
  end
  
end
