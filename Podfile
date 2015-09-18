source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '7.0'
inhibit_all_warnings!

pod 'AFNetworking', '~> 2.5'
pod 'EGOCache', '~> 2.1'
pod 'UAProgressView', '~> 0.1'

target :FSImageViewerDemo, :exclusive => true do
    link_with ['FSImageViewer']
end

target :FSImageViewerTests, :exclusive => true do
	pod 'OCMock', '~> 3.1'
	pod 'FBSnapshotTestCase/Core', '~> 2.0'
end