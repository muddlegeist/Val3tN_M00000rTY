# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

use_frameworks!

target 'ValetAndMorty' do
  
  

  pod 'Valet', :git => 'https://github.com/square/Valet.git', :branch => 'develop/3.0'

end

post_install do |installer|
installer.pods_project.targets.each do |target|
target.build_configurations.each do |config|
config.build_settings['SWIFT_VERSION'] = '3.2'
end
end
end