Pod::Spec.new do |s|
  s.name        = "ZZListKit"
  s.version     = "0.0.1"
  s.homepage    = "https://github.com/zhengyi21st/ZZListKit"
  s.source = { :git => "https://github.com/zhengyi21st/ZZListKit.git", :tag => s.version }
  s.license     = { :type => "MIT" }
  s.authors     = { "ethan" => "zhengyi21st@gmail.com" }
  s.summary     = "A short description of ZZListKit."
  
  s.requires_arc = true
  s.swift_version = '5.0'
  s.ios.deployment_target = '11.0'
  s.source_files = "Sources/**/*.{swift}"
  
  s.dependency 'MJRefresh', '~> 3.7.5'
  s.dependency 'ZZComponents/Color'
  
end
