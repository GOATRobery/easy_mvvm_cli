require 'easy_mvvm/parser'

module EasyMvvm
  class ModelParser < Parser
    def render_template_file
      render_erb_file(yaml_file_path) do
        YAML.load_file(yaml_file_path).values.flatten.each { |each_line| deal_template_config(each_line) }
      end
    end

    def render_erb_file(source_file_path)
      erb_file_string = File.read(source_file_path)
      need_render_file = ERB.new(erb_file_string)
      page_name = @generator.model_name
      project_name = ProjectHandler.project_name
      model_name = @generator.model_name
      author_name = @generator.author_name
      date = Time.now.strftime("%Y/%m/%d")
      ProjectHandler.write_to_file(source_file_path, need_render_file.result(binding))
      yield
      ProjectHandler.write_to_file(source_file_path, erb_file_string)
    end
  end
end
