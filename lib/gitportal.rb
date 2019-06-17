require "redcarpet"
require "gitportal/engine"
require "gitportal/configuration"
require "gitportal/version"

module Gitportal
  class << self
    def config
      return @config if defined?(@config)
      @config = Configuration.new
      @config.ghp_owner = nil
      @config.ghp_repo = nil
      @config.ghp_username = nil
      @config.ghp_token = nil
      @config
    end

    def configure(&block)
      config.instance_exec(&block)
    end
  end
end
