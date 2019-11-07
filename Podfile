platform :ios, '9.0'

inhibit_all_warnings!

def utils
    pod 'SwiftGen', '~> 6.1.0'
    pod 'SwiftLint', '~> 0.30.1'
end

def common_pods
    utils
    pod 'RealmSwift'
    pod 'SwiftGifOrigin', '~> 1.7.0'
end

target 'GiphyMVP' do
    use_frameworks!
    common_pods
end
