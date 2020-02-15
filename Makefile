ARCHS = arm64 arm64e
TARGET = iphone:11.2:11.2

PACKAGE_VERSION = $(THEOS_PACKAGE_BASE_VERSION)
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ColorSwitches
ColorSwitches_FILES = Tweak.xm
ColorSwitches_CFLAGS = -fobjc-arc
ColorSwitches_LIBRARIES = colorpicker

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += colorswitchesprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
