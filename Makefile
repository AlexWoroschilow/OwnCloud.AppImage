SOURCE="https://download.opensuse.org/repositories/isv:/ownCloud:/desktop/CentOS_7.6/x86_64/owncloud-client-2.6.3-2668.1.x86_64.rpm"
DESTINATION="owncloud.rpm"
OUTPUT="OwnCloud.AppImage"
PWD=$(shell pwd)

all:
	echo "Building: $(OUTPUT)"
	wget --output-document=$(DESTINATION) --continue $(SOURCE)
	wget --output-document=build.rpm --continue  https://ftp.lysator.liu.se/pub/opensuse/distribution/leap/15.1/repo/oss/x86_64/libqt5keychain1-0.9.1-lp151.1.1.x86_64.rpm
	rpm2cpio build.rpm | cpio -idmv
	rm -f build.rpm

	wget --output-document=build.rpm --continue http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/qt5-qtbase-5.12.5-4.el8.x86_64.rpm
	rpm2cpio build.rpm | cpio -idmv
	rm -f build.rpm

	wget --output-document=build.rpm --continue https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/o/openssl11-libs-1.1.1c-2.el7.x86_64.rpm
	rpm2cpio build.rpm | cpio -idmv
	rm -f build.rpm

	wget --output-document=build.rpm --continue http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/libicu-60.3-2.el8_1.x86_64.rpm
	rpm2cpio build.rpm | cpio -idmv
	rm -f build.rpm

	wget --output-document=build.rpm --continue http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/qt5-qtbase-gui-5.12.5-4.el8.x86_64.rpm
	rpm2cpio build.rpm | cpio -idmv
	rm -f build.rpm

	wget --output-document=build.rpm --continue http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/qt5-qtbase-gui-5.12.5-4.el8.x86_64.rpm
	rpm2cpio build.rpm | cpio -idmv
	rm -f build.rpm

	wget --output-document=build.rpm --continue http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/libpng-1.6.34-5.el8.x86_64.rpm
	rpm2cpio build.rpm | cpio -idmv
	rm -f build.rpm

	
	rpm2cpio $(DESTINATION) | cpio -idmv
	
	mkdir -p AppDir/application
	mkdir -p AppDir/lib
	
	cp -r opt/ownCloud/ownCloud/bin/* AppDir/application
	cp -r opt/ownCloud/ownCloud/lib64/* AppDir/lib
	cp -r usr/lib64/* AppDir/lib

	
	chmod +x AppDir/AppRun
	export ARCH=x86_64 && bin/appimagetool.AppImage AppDir $(OUTPUT)
	chmod +x $(OUTPUT)
	
	#rm -rf *.rpm
	#rm -rf AppDir/application
	#rm -rf AppDir/lib
	#rm -rf usr
	#rm -rf opt
	#rm -rf etc
