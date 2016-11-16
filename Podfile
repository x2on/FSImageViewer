source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '7.0'
inhibit_all_warnings!

def image_viewer
	pod 'AFNetworking', '~> 3.0'
	pod 'EGOCache', '~> 2.1'
	pod 'UAProgressView', '~> 0.1'
end

target 'FSImageViewer' do
    image_viewer
end

target 'FSImageViewerDemo' do
    image_viewer
end

target 'FSImageViewerTests' do
	pod 'OCMock', '~> 3.1'
	pod 'FBSnapshotTestCase/Core', '~> 2.0'
end
