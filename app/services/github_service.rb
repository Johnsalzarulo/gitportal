class GithubService

  def initialize
    @api_params = {}
    @api_params[:owner] = ENV['GHPOWNER']
    @api_params[:repo] = ENV['GHPREPO']
    @api_params[:headers] = {
      "User-Agent" => ENV['GHPUSERNAME']
    }
    @api_params[:auth] = {
      :username => ENV['GHPUSERNAME'],
      :password => ENV['GHPTOKEN']
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

  def issue(number)
    HTTParty.get(
      "#{@api_params[:base_url]}/repos/#{@api_params[:owner]}/#{@api_params[:repo]}/issues/#{number}",
      :headers => @api_params[:headers],
      :basic_auth =>  @api_params[:auth]
    )
  end


end
