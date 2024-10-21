target 'RecenziRAJ' do
  use_frameworks!

  # Pods for RecenziRAJ
  pod 'SnapKit', '~> 5.6.0'
  pod 'FirebaseCore'
  pod 'FirebaseAuth'
  pod 'FirebaseFirestore'
  pod 'FirebaseDatabase'
  pod 'FirebaseStorage'
  pod 'lottie-ios'
  pod 'FirebaseUI'
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings["IPHONEOS_DEPLOYMENT_TARGET"] = "13.0"
      end
    end
  end
  
end
