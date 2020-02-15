#import "libcolorpicker.h"

@interface UISwitchModernVisualElement : UIView
	-(id)initWithFrame:(CGRect)arg1;
	-(id)_effectiveOnTintColor;
	-(id)_effectiveTintColor;
@end

//Paths to plists, use separate "defaults" for color values and switches (toggles). - otherwise multiple resprings required.
#define prefPath @"/var/mobile/Library/Preferences/com.idevicehacked.colorswitchesprefs.color.plist"
#define switchPath @"/var/mobile/Library/Preferences/com.idevicehacked.colorswitchesprefs.plist"

static NSMutableDictionary *prefs = nil;
static NSMutableDictionary *switches = nil;
static NSString *kSwitchOnColor = nil;
static NSString *kSwitchOffColor = nil;
static NSString *kSwitchKnobColor = nil;
static NSString *kSwitchColors = nil;

static void loadPrefs()
{
  prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:prefPath];
  switches = [[NSMutableDictionary alloc] initWithContentsOfFile:switchPath];

  kSwitchOnColor = [prefs objectForKey:@"kSwitchOnColor"];
  kSwitchOffColor = [prefs objectForKey:@"kSwitchOffColor"];
  kSwitchKnobColor = [prefs objectForKey:@"kSwitchKnobColor"];
  kSwitchColors = [prefs objectForKey:@"kSwitchColors"];

}

//LoadPrefs notification
static void receivedNotification(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
  loadPrefs();
}

//Switch Colors
%hook UISwitchModernVisualElement

//For system apps
-(id)initWithFrame:(CGRect)arg1 {
	if ([[switches objectForKey:@"kSwitchColors"] boolValue] == YES) {
		MSHookIvar<UIColor*>(self, "_onTintColor") = LCPParseColorString(kSwitchOnColor, @"#1100FF");
		MSHookIvar<UIColor*>(self, "_tintColor") = LCPParseColorString(kSwitchOffColor, @"#6500FF");
		MSHookIvar<UIColor*>(self, "_thumbTintColor") = LCPParseColorString(kSwitchKnobColor, @"#0080FF");
	}
	return %orig;
}

//Only thing needed for 3rd party apps
-(id)_effectiveOnTintColor {
	if ([[switches objectForKey:@"kSwitchColors"] boolValue] == YES) {
		return LCPParseColorString(kSwitchOnColor, @"#1100FF");
		//LCPParseColorString(kSwitchOnColor, @"#007D00"); //This grabs the color hex from prefs - #007D00 is the fallback color in case of error. Should match fallback in prefs plist.
	} else {
		return %orig;
	}
}

-(id)_effectiveTintColor {
	if ([[switches objectForKey:@"kSwitchColors"] boolValue] == YES) {
		return LCPParseColorString(kSwitchOffColor, @"#6500FF");
	} else {
		return %orig;
	}
}

%end

//Observer for LoadPrefs notification
%ctor {
	CFNotificationCenterAddObserver(
    CFNotificationCenterGetDarwinNotifyCenter(),
    NULL,
    receivedNotification,
    CFSTR("com.idevicehacked.colorswitchesprefs/color.changed"),
    NULL,
    CFNotificationSuspensionBehaviorCoalesce);
    loadPrefs();
}