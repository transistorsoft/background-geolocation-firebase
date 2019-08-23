require 'json'

package = JSON.parse(File.read(File.join(__dir__, '../package.json')))

Pod::Spec.new do |s|
  s.name                = 'BackgroundGeolocationFirebase'
  s.version             = package['version']
  s.summary             = package['description']
  s.description         = <<-DESC
    Firebase adapter for background-geolocation
  DESC
  s.homepage            = package['homepage']
  s.license             = package['license']
  s.author              = package['author']
  s.source              = { :git => package['repository']['url'], :tag => s.version }
  s.platform            = :ios, '8.0'

  s.preserve_paths      = 'docs', 'CHANGELOG.md', 'LICENSE', 'package.json'
  s.source_files        = 'BackgroundGeolocationFirebase/*.{h,m}'
  s.dependency 'Firebase/Core'
  s.dependency 'Firebase/Firestore'
end
