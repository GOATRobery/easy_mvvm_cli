require 'easy_mvvm/parser'

module EasyMvvm
  class PageParser < Parser
    def render_template_file
      @generator.page_name_array.each do |each_page_name|
        @page_name = each_page_name
        render_erb_file(yaml_file_path) do
          YAML.load_file(yaml_file_path).values.flatten.each { |each_line| deal_template_config(each_line) }
        end
      end
    end

    def render_erb_file(source_file_path)
      erb_file_string = File.read(source_file_path)
      need_render_file = ERB.new(erb_file_string)
      page_name = @page_name
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
