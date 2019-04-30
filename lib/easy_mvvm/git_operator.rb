begin
  require 'git'
rescue Git::GitExecuteError => e
  $stderr.puts 'WARNING: Git is not installed in your system. Please install git first'
end
require 'digest/sha2'
require 'fileutils'

module EasyMvvm

  class GitOperator
    def initialize(is_default_template, template_download_path, cli_name)
      @is_default_template = is_default_template
      @template_download_path = template_download_path
      @cli_name = cli_name
    end

    def run
      fetch(@template_download_path, template_repo_path)
      [author_name, File.join(template_repo_path, @cli_name)]
    end

    def template_cache_dir
      FileUtils.mkpath(Dir.home + '/.easy_mvvm/template_cache')
    end

    def author_name
      Git.global_config('user.name')
    end

    def template_repo_name
      repo_name = File.basename(@template_download_path, '.git')
      if @is_default_template
        repo_name
      else
        repo_name = Digest::SHA1.hexdigest(repo_name)
      end
    end

    def template_repo_path
      File.join(template_cache_dir, template_repo_name)
    end

    def fetch(giturl, path)
      # We pull if clone exists
      if File.directory?(path + '/.git')
        c = Git.open(path)
        begin
        c.pull
        rescue Git::GitExecuteError => e
          $stderr.puts e.message
          3.times do
            begin
              FileUtils.rm_rf path
              Git.clone giturl, path
              break
            rescue Git::GitExecuteError => e
              $stderr.puts e.message
            end
          end
        end
      else
        begin
          Git.clone giturl, path
        rescue Git::GitExecuteError => e
          $stderr.puts e.message
        end
      end
    end
  end

end

