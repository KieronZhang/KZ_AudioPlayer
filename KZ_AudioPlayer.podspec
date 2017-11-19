
Pod::Spec.new do |s|

    s.name = 'KZ_AudioPlayer'
    s.version = '0.1'
    s.summary = 'iOS audio player.'
    s.homepage = 'https://github.com/KieronZhang/KZ_AudioPlayer'
    s.license = {:type => 'MIT', :file => 'LICENSE'}
    s.author = {'KieronZhang.' => 'https://github.com/KieronZhang'}
    s.platform = :ios, '8.0'
    s.source = {:git => 'https://github.com/KieronZhang/KZ_AudioPlayer.git', :tag => s.version, :submodules => true}
    s.xcconfig = {'OTHER_LDFLAGS' => '-ObjC'}
    s.frameworks = 'UIKit', 'Foundation', 'AVFoundation'
    s.vendored_frameworks = 'KZ_AudioPlayer/KZ_AudioPlayerFramework.framework'
    s.requires_arc = true

end
