Pod::Spec.new do |s|
  s.name         = "SmartSenseDemoCode"
  s.version      = "1.0.0"
  s.summary      = "SmartSenseDemoCode is generalised startup code of iOS project."

  s.description  = "SmartSenseDemoCode is generalised startup code of any iOS project. Which reduced time and workload"

  s.homepage     = "http://www.smartsensesolutions.com/"
 
  s.license      = "MIT"

  s.author             = { "krunal_smartsense" => "krunal.smartsensesolutions@gmail.com" }
  s.platform     = :ios, "10.0"

  s.source       = { :git => "https://github.com/smartKrunal/smartServiceManagesTwo", :tag => "1.0.0" }

  s.source_files  = "SmartSenseDemoCode", "SmartSenseDemoCode/**/*.{h,m,swift}"

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '2.2' }

end
