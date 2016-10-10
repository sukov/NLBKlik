use_frameworks!

 pod 'SnapKit', '~> 0.22.0’

post_install do |installer|
installer.pods_project.targets.each do |target|
target.build_configurations.each do |config|
config.build_settings['SWIFT_VERSION'] = '2.3'
end
end
end