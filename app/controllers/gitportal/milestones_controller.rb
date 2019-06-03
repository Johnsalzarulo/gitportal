class Gitportal::MilestonesController < ApplicationController

  def index
    @milestones = GithubService.new.milestones
  end

  def show
    @milestone = GithubService.new.milestone(params[:id])
    @issues = GithubService.new.issues_by_milestone(params[:id])
  end

end