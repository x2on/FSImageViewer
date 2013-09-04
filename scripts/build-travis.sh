#!/bin/sh

echo "Build"
xcodebuild -workspace FSImageViewer.xcworkspace -scheme FSImageViewer -sdk iphonesimulator build ONLY_ACTIVE_ARCH=NO

echo "Validate PodSpec"
pod --version
pod spec lint FSImageViewer.podspec