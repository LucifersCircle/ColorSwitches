ARCHS = arm64 arm64e
TARGET = iphone:11.2:11.2

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = colorswitchesprefs
colorswitchesprefs_FILES = iDHColorSwitchesRootListController.m
colorswitchesprefs_INSTALL_PATH = /Library/PreferenceBundles
colorswitchesprefs_FRAMEWORKS = UIKit
colorswitchesprefs_PRIVATE_FRAMEWORKS = Preferences
colorswitchesprefs_CFLAGS = -fobjc-arc
colorswitchesprefs_LIBRARIES = colorpicker

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/colorswitchesprefs.plist$(ECHO_END)
