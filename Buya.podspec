Pod::Spec.new do |spec|
  spec.name               = 'Buya'
  spec.version            = '1.0.2'
  spec.summary            = 'Network abstraction framework'
  spec.homepage           = 'https://github.com/Puasonych/Buya'
  spec.license            = { :type => 'MIT', :file => 'LICENSE' }
  spec.authors            = { 'Erik Basargin' => 'basargin.erik@gmail.com', 'Kirill Saltykov' => 'kirill.salti@gmail.com' }
  spec.social_media_url   = 'https://twitter.com/Puasonych'
  spec.source             = { :git => 'https://github.com/Puasonych/Buya.git', :tag => spec.version }
  spec.swift_version      = '5'

  spec.ios.deployment_target  = '8.0'

  spec.default_subspec = 'Core'

  spec.subspec 'Core' do |subspec|
    subspec.source_files = 'Buya/**/*.swift'
    subspec.framework = 'Foundation'
    subspec.dependency 'RxSwift', '~> 4.5'
    subspec.dependency 'RxCocoa', '~> 4.5'
  end
end
