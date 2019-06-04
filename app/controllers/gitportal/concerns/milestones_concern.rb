module Gitportal::Concerns::MilestonesConcern
  extend ActiveSupport::Concern

  def index
    @milestones = GithubService.new.milestones
  end

  def show
    @milestone = GithubService.new.milestone(params[:id])
    #@issues = GithubService.new.issues_by_milestone(params[:id])
    @issues = GithubGraphqlService.issues_by_milestone(Gitportal.config.ghp_owner, Gitportal.config.ghp_repo, params[:id].to_i)
    @issues = @issues.data.repository.milestone.issues.edges.map {|m| m.node }
  end

end
