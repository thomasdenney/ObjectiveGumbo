Pod::Spec.new do |s|
  s.name = 'ObjectiveGumbo'
  s.version = '0.2'
  s.license = {:type => 'Apache', :file => 'ObjectiveGumbo/LICENSE'}
  s.summary = 'Objective-C/Swift-compatible library for easier and safer interacting with data inside HTML content'
  s.homepage = 'https://github.com/rwarrender/ObjectiveGumbo'
  s.authors = {'Programming Thomas' => 'programmingthomas@gmail.com',
                'Richard Warrender' => 'richard@vividreflection.com'}
  s.source = {:git => 'https://github.com/rwarrender/ObjectiveGumbo.git', :tag => s.version.to_s}
  s.source_files = 'ObjectiveGumbo/**/*.{h,m,c}'
  s.private_header_files = 'ObjectiveGumbo/Gumbo/*.h', 'ObjectiveGumbo/*Private.h'
  s.requires_arc = true
  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.12'
end