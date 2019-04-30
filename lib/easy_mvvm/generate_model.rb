require 'easy_mvvm/configurator'
require 'easy_mvvm/git_operator'
require 'easy_mvvm/parser/model_parser'

module EasyMvvm
  class GenerateModel
    attr_reader :model_name, :author_name, :template_repo_path
    def initialize(model_name)
      @model_name = model_name
    end

    def run
      @author_name, @template_repo_path = EasyMvvm::Configurator.new(:model.to_s).run
      EasyMvvm::ModelParser.new(self).run
    end
  end
end

