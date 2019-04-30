
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'easy_mvvm/version'

Gem::Specification.new do |spec|
  spec.name          = 'easy_mvvm'
  spec.version       = EasyMvvm::VERSION
  spec.authors       = ['PuffLady', 'momo462']
  spec.email         = ['dxylzn@163.com', '248196120@qq.com']

  spec.summary       = %q{The cli for the EasyMVVM framework}
  spec.description   = %q{The cli for the EasyMVVM framework, which help you quick start with a template project}
  spec.homepage      = "https://github.com/Meituan-Dianping/easy_mvvm_cli"
  spec.license       = "Apache License 2.0"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rubocop"
  spec.add_dependency "thor"
  spec.add_dependency "git"
  spec.add_dependency "activesupport"
  spec.add_dependency "cocoapods"
end
