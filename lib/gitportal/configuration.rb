module Gitportal
  class Configuration
    # Owner of the Github repo
    attr_accessor :ghp_owner

    # Github repo
    attr_accessor :ghp_repo

    # Github username
    attr_accessor :ghp_username

    # Github token
    attr_accessor :ghp_token

  end
end
