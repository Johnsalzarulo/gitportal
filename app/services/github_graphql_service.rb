require "graphql/client"
require "graphql/client/http"

module GithubGraphqlService
  GITHUB_ACCESS_TOKEN = Gitportal.config.ghp_token
  URL = 'https://api.github.com/graphql'

  HttpAdapter = GraphQL::Client::HTTP.new(URL) do
    def headers(context)
      {
        "Authorization" => "Bearer #{GITHUB_ACCESS_TOKEN}",
        "User-Agent" => 'Ruby'
      }
    end
  end

  Schema = GraphQL::Client.load_schema(HttpAdapter)
  Client = GraphQL::Client.new(schema: Schema, execute: HttpAdapter)

  MILESTONES_QUERY = GithubGraphqlService::Client.parse <<-'GRAPHQL'
  query{
    organization(login: "withbetterco") {
      repository(name: "wellstart") {
        name
        url
        milestones (first: 100,
        states: [OPEN],
         orderBy: {field: CREATED_AT, direction: DESC},
         ){
          edges {
            node {
              id,
              number,
              title
            }
          }
        }
      }
    }
  }
  GRAPHQL

  ISSUES_BY_MILESTONE = GithubGraphqlService::Client.parse <<-'GRAPHQL'
  query($owner:String!,$name:String!,$milestoneNumber:Int!) {
    repository(owner:$owner,name:$name) {
      milestone(number:$milestoneNumber) {
        issues(states: [OPEN], first:10) {
          edges {
            node {
              number
              title
              createdAt
              labels(first:20) {
                edges {
                  node {
                    name
                    color
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  GRAPHQL

  def self.milestones
    response = GithubGraphqlService::Client.query(MILESTONES_QUERY)
    response.data
  end

  def self.issues_by_milestone(owner, repo, milestone_number)
    response = GithubGraphqlService::Client.query(ISSUES_BY_MILESTONE, variables: { owner: owner, name: repo, milestoneNumber: milestone_number })
  end

end
