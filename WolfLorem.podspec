Pod::Spec.new do |s|
    s.name             = 'WolfLorem'
    s.version          = '2.0.0'
    s.summary          = 'Functions to generate random placeholders in the style of Lorem Ipsum.'

    s.description      = <<-DESC
    WolfLorem contains functions to generate random placeholders and dummy data in the style of Lorem Ipsum. Not just sentences, but words, paragraphs, male or female proper names, screen names, titles, phone numbers, email addresses, tweets, dates in the past or future, record IDs, UUIDs, passwords, avatar URLs, image URLs, and more. Very useful during development!
    DESC

    s.homepage         = 'https://github.com/wolfmcnally/WolfLorem'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Wolf McNally' => 'wolf@wolfmcnally.com' }
    s.source           = { :git => 'https://github.com/wolfmcnally/WolfLorem.git', :tag => s.version.to_s }

    s.source_files = 'Sources/WolfLorem/**/*'

    s.swift_version = '5.0'

    s.ios.deployment_target = '9.3'
    s.macos.deployment_target = '10.13'
    s.tvos.deployment_target = '11.0'

    s.module_name = 'WolfLorem'

    s.dependency 'WolfNumerics'
end
