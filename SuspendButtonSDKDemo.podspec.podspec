Pod::Spec.new do |s|

  s.name         = 'SuspendButtonSDKDemo'
  s.version      = '1.0.0'
  s.summary      = 'creat a project for learn to use how SDK use Cocopod manage'

  s.homepage     = 'https://github.com/yourks/JionCocopodTest'



  s.license      = { :type => ‘MIT’, :tag => '1.0.0' }


  s.author       = { 'codeliu6572' => 'codeliu6572@163.com' }

  s.source       = { :git => 'https://github.com/yourks/JionCocopodTest.git', :tag => '1.0.0' }



  s.source_files  = 'SuspendButtonSDKDemo/SuspendButton/*.{h,m}'


  s.framework  = 'UIKit'
  s.requires_arc = true
end

