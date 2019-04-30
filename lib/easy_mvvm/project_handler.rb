module EasyMvvm
  class ProjectHandler
    def self.project_name
      podspec_array = Dir.glob('*.podspec')
      File.basename(podspec_array[0], '.podspec')
    end

    def self.classes_path
      File.join(Dir.pwd, File.join(self.project_name, 'Classes'))
    end

    def self.write_to_file(path, content)
      File.open(path, 'w') { |file| file.puts content}
    end
  end
end