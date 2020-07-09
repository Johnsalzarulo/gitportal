class GithubService

  def initialize
    @api_params = {}
    @api_params[:owner] = Gitportal.config.ghp_owner
    @api_params[:repo] = Gitportal.config.ghp_repo
    @api_params[:headers] = {
      "User-Agent" => Gitportal.config.ghp_username
    }
    @api_params[:auth] = {
      :username => Gitportal.config.ghp_username,
      :password => Gitportal.config.ghp_token
    }
   @api_params[:base_url] = 'https://api.github.com'
  end


  def pull_requests
    data = HTTParty.get(
      "#{@api_params[:base_url]}/repos/#{@api_params[:owner]}/#{@api_params[:repo]}/pulls?state=closed&page=1&per_page=50&sort=merged_at&direction=desc",
      :headers => @api_params[:headers],
      :basic_auth =>  @api_params[:auth]
    )
  end

  def issues
    HTTParty.get(
      "#{@api_params[:base_url]}/repos/#{@api_params[:owner]}/#{@api_params[:repo]}/issues?state=open&page=1&per_page=99",
      :headers => @api_params[:headers],
      :basic_auth =>  @api_params[:auth]
    )
  end

  def issue(number)
    HTTParty.get(
      "#{@api_params[:base_url]}/repos/#{@api_params[:owner]}/#{@api_params[:repo]}/issues/#{number}",
      :headers => @api_params[:headers],
      :basic_auth =>  @api_params[:auth]
    )
  end

  def milestones
    HTTParty.get(
      "#{@api_params[:base_url]}/repos/#{@api_params[:owner]}/#{@api_params[:repo]}/milestones?state=open",
      :headers => @api_params[:headers],
      :basic_auth =>  @api_params[:auth]
    )
  end

  def milestone(milestone_number)
    HTTParty.get(
      "#{@api_params[:base_url]}/repos/#{@api_params[:owner]}/#{@api_params[:repo]}/milestones/#{milestone_number}",
      :headers => @api_params[:headers],
      :basic_auth =>  @api_params[:auth]
    )
  end

  def issues_by_milestone(milestone_number)
    HTTParty.get(
      "#{@api_params[:base_url]}/repos/#{@api_params[:owner]}/#{@api_params[:repo]}/issues?milestone=#{milestone_number}&page=1&per_page=10",
      :headers => @api_params[:headers],
      :basic_auth =>  @api_params[:auth]
    )
  end

  def closed_issues
    HTTParty.get(
      "#{@api_params[:base_url]}/repos/#{@api_params[:owner]}/#{@api_params[:repo]}/issues?state=closed&page=1&per_page=99",
      :headers => @api_params[:headers],
      :basic_auth =>  @api_params[:auth]
    )
  end

  def isssues_by_label_id(label)
    @safe_label = URI::encode(label)
    HTTParty.get(
      "#{@api_params[:base_url]}/repos/#{@api_params[:owner]}/#{@api_params[:repo]}/issues?labels=#{@safe_label}",
      :headers => @api_params[:headers],
      :basic_auth =>  @api_params[:auth]
    )
  end

  def closed_isssues_by_label_id(label)
    @safe_label = URI::encode(label)
    HTTParty.get(
      "#{@api_params[:base_url]}/repos/#{@api_params[:owner]}/#{@api_params[:repo]}/issues?labels=#{@safe_label}&state=closed",
      :headers => @api_params[:headers],
      :basic_auth =>  @api_params[:auth]
    )
  end

  def labels
    HTTParty.get(
      "#{@api_params[:base_url]}/repos/#{@api_params[:owner]}/#{@api_params[:repo]}/labels",
      :headers => @api_params[:headers],
      :basic_auth =>  @api_params[:auth]
    )
  end

end
