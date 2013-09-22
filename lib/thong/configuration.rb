module Thong
  module Configuration
    require 'yaml'

    def self.configuration
      config = {
        :git => git,
      }
      if yml = self.yaml_config
        config[:configuratiom] = yml
        config[:thong_url] = yml.fetch(:thong_url) { "http://localhost:3000" }
      else
        puts "[Thong] No configuration file found. Will not send data anywhere.".colorize(:red)
      end
      config
    end

    def self.yaml_config
      if self.config_file && File.exists?(self.config_file)
        YAML::load_file(self.config_file)
      end
    end

    def self.config_file
      File.expand_path(File.join(Dir.pwd, ".thong.yml"))
    end

    def self.git
      git_hash = {}

      git_hash[:head] = {
        :id => `git log -1 --pretty=format:'%H'`,
        :author_name => `git log -1 --pretty=format:'%aN'`,
        :author_email => `git log -1 --pretty=format:'%ae'`,
        :committer_name => `git log -1 --pretty=format:'%cN'`,
        :committer_email => `git log -1 --pretty=format:'%ce'`,
        :message => `git log -1 --pretty=format:'%s'`
      }

      branch = `git branch`.split("\n").delete_if { |i| i[0] != "*" }
      git_hash[:branch] = [branch].flatten.first.gsub("* ","")

      remotes = nil
      begin
        remotes = `git remote -v`.split(/\n/).map do |remote|
          splits = remote.split(" ").compact
          {:name => splits[0], :url => splits[1]}
        end.uniq
      rescue
      end

      git_hash[:remotes] = remotes

      git_hash

    end
  end
end
