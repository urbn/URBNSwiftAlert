Pod::Spec.new do |s|
s.name             = 'URBNSwiftAlert'
s.version          = '1.5'
s.summary          = 'A swift version of URBNAlert by Ryan Garchinsky.'


s.homepage         = 'https://github.com/URBN/URBNSwiftAlert'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Kevin Taniguchi' => 'ktaniguchi@urbn.com' }
s.source           = { :git => 'git@github.com:urbn/URBNSwiftAlert.git', :tag => s.version.to_s }
s.platform         = :ios, '10.0'
s.requires_arc     = true
s.source_files     = 'URBNSwiftAlert/Classes/**/*'
s.dependency 'URBNSwiftyConvenience', '~> 1.0'
end
