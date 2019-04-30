
module EasyMvvm
  class FileTemplateConfig
    attr_accessor :from_path, :to_path
    def initialize(hash, from_path, to_path)
      @from_path = File.join(from_path, hash[:from.to_s])
      @to_path = File.join(to_path, hash[:to.to_s])
    end

    def create_path(to_path)
      FileUtils.mkdir_p to_path unless Dir.exist?(to_path)
    end

    def move
      create_path File.dirname(@to_path)
      FileUtils.cp @from_path, @to_path
    end
  end
end
