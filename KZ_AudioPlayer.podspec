
Pod::Spec.new do |s|

    s.name = 'KZ_AudioPlayer'
    s.version = '0.1.1'
    s.summary = 'iOS audio player.'
    s.homepage = 'https://github.com/KieronZhang/KZ_AudioPlayer'
    s.license = {:type => 'MIT', :file => 'LICENSE'}
    s.author = {'KieronZhang' => 'https://github.com/KieronZhang'}

    s.source = {:git => 'https://github.com/KieronZhang/KZ_AudioPlayer.git', :tag => s.version, :submodules => true}
    s.xcconfig = {'OTHER_LDFLAGS' => '-ObjC'}
    s.requires_arc = true

    s.ios.frameworks = 'Foundation', 'UIKit', 'AVFoundation'

    s.ios.deployment_target = '8.0'

    s.ios.vendored_frameworks = 'KZ_AudioPlayer/KZ_AudioPlayer_iOS.framework'

end
