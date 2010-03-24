module Subcheat
  class SubversionWorkingCopy
    attr_reader :path

    def initialize(path)
      raise Subcheat::NotAWorkingCopy unless File.directory?(File.join(path, '.svn'))
      @path = path
    end

    %w{delete list copy merge switch export update}.each do |name|
      define_method(name.to_sym) do |*args|
        `svn #{[*args].join(' ')}`
      end
    end

    # Shortcut method to the base url for the current project in the current repo.
    def base_url
      attr('URL').split(/branches|tags|trunk/).first
    end

    # Extract a working copy attribute, like URL or revision number.
    def attr(name)
      info[/^#{name}: (.+?)$/, 1]
    end

    # Read the Subversion logs for a given path.
    def log(repo, *arguments)
      `svn log #{repo} #{[*arguments].join(' ')}`
    end

    # Retrieve information about the working copy.
    def info
      @info ||= `svn info #{@path}`
    end
  end
end