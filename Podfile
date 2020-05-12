
platform :ios, '9.0'
inhibit_all_warnings!
flutter_application_path = './my_flutter/'
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')

target 'OCAndFlutter' do
  install_all_flutter_pods(flutter_application_path)
  use_frameworks!

  pod 'AFNetworking'
  pod 'Base64'
  pod 'JSBadgeView'
  pod 'SDWebImage'
end
