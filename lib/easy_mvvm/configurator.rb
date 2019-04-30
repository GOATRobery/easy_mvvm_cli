require 'yaml'

module EasyMvvm
  class Configurator
    def initialize(cli_name)
      @is_default_template = true
      @cli_name = cli_name
    end

    def default_config
      File.join Dir.home, '.easy_mvvm/config.yml'
    end

    def gem_config
      File.join(File.expand_path("../../../", __FILE__), 'config.yml')
    end

    def working_config
      File.join Dir.pwd, 'easy_mvvm_config.yml'
    end

    def default_dir
      FileUtils.mkpath Dir.home + '/.easy_mvvm'
    end

    def obtain_config_path
      if File.exist? working_config
        @is_default_template = false
        working_config
      elsif File.exist? default_config
        default_config
      else
        default_dir
        FileUtils.cp gem_config, default_config
        default_config
      end
    end

    def read_config
      config_hash = YAML.load_file(obtain_config_path)
      config_hash['default_template']
    end

    def run
      EasyMvvm::GitOperator.new(@is_default_template, read_config, @cli_name).run
    end
  end
end
