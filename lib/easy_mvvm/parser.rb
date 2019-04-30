require 'erb'
require 'active_support/inflector/inflections'
require 'cocoapods'
require 'easy_mvvm/template_config'
require 'easy_mvvm/project_handler'

module EasyMvvm
  class Parser
    def initialize(generator)
      @generator = generator
      @template_repo_path = generator.template_repo_path
    end

    def run
      create_tmp_template
      render_template_file
      remove_tmp_template
      # pod_install
    end

    def create_tmp_template
      tmp_template_path = @template_repo_path + '_tmp'
      FileUtils.cp_r @template_repo_path, tmp_template_path
      @template_repo_path = tmp_template_path
    end

    def deal_template_config(template_hash)
      template_config = FileTemplateConfig.new(template_hash, @template_repo_path, ProjectHandler.classes_path)
      render_erb_file(template_config.from_path) do
        template_config.move
      end
    end

    def remove_tmp_template
      Dir.chdir(File.dirname(@template_repo_path)) do
        tmp_template_name = File.basename(@template_repo_path)
        FileUtils.rm_rf tmp_template_name if Dir.exist?(tmp_template_name)
      end
    end

    def pod_install
      Dir.chdir(File.join(Dir.pwd, 'Example')) do
        Pod::Command::Install.run([])
      end
    end

    def yaml_file_path
      File.join(@template_repo_path, 'template.yml')
    end
  end
end