Pod::Spec.new do |s|
s.name             = 'URBNSwiftAlert'
s.version          = '0.1.0'
s.summary          = 'A swift version of URBNAlert by Ryan Garchinsky.'


s.homepage         = 'https://github.com/URBN/URBNSwiftAlert'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Kevin Taniguchi' => 'ktaniguchi@urbn.com' }
s.source           = { :git => 'git@github.com:urbn/URBNSwiftAlert.git', :tag => s.version.to_s }
s.ios.deployment_target = '10.3'
s.source_files = 'URBNSwiftAlert/Classes/**/*'
s.dependency 'URBNSwiftyConvenience'
end
