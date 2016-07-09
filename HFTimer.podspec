Pod::Spec.new do |s|

  s.name                  = "HFTimer"
  s.version               = "0.0.2"
  s.summary               = "自己做的一个可以自动销毁timer "


  s.homepage              = "https://github.com/helfyz/HFTimer"
  s.license               = 'MIT'
  s.author                = { "helfy" => "562812743@qq.com" }
  s.platform              = :ios, "7.0"
  s.ios.deployment_target = '7.0'
  s.source                = { :git => "https://github.com/helfyz/HFTimer.git", :tag => s.version, :submodules => true}
  s.source_files          = "HFTimer/*.{h,m}"
  s.public_header_files   = "HFTimer/*.h"
  s.frameworks            = 'Foundation', 'CoreGraphics', 'UIKit'
  s.requires_arc          = true


end
