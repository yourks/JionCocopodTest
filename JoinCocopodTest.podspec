
Pod::Spec.new do |s|
    s.name         = 'JoinCocopodTest'
    s.version      = '1.0.6'
    s.summary      = 'creat a project for learn to use how SDK use Cocopod manage'
    s.homepage     = 'https://github.com/yourks/JionCocopodTest'
    s.license      = 'MIT'
    s.authors      = {'MJ Lee' => '199109106@qq.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/yourks/JionCocopodTest.git', :tag => s.version}
    s.source_files = 'JoinCocopodTest/*.{h,m}'
    s.requires_arc = true
    s.dependency 'Masonry', '~> 1.0.2'

end