require 'thor'
require 'easy_mvvm/generate_model'
require 'easy_mvvm/generate_page'

module EasyMvvmCli
  class Generate < Thor
    desc 'generate model', 'generate EasyMvvm Model project'
    def model(model_name)
      ::EasyMvvm::GenerateModel.new(model_name).run
    end

    desc 'generate page', 'generate EasyMvvm Page project'
    def page(model_name, *page_name_array)
      ::EasyMvvm::GeneratePage.new(model_name, page_name_array).run
    end
  end
  class EasyMvvm < Thor
    desc "generate SUBCOMMAND ...ARGS", "generate template"
    subcommand "generate", Generate
  end
end



# EasyMvvm::Generate.new.model('haha')