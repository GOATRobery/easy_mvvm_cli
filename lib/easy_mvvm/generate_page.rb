require 'easy_mvvm/configurator'
require 'easy_mvvm/git_operator'
require 'easy_mvvm/parser/page_parser'

module EasyMvvm
  class GeneratePage
    attr_reader :model_name, :author_name, :template_repo_path, :page_name_array
    def initialize(model_name, page_name_array)
      @model_name = model_name
      @page_name_array = page_name_array
    end

    def run
      @author_name, @template_repo_path = EasyMvvm::Configurator.new(:page.to_s).run
      EasyMvvm::PageParser.new(self).run
    end
  end
end