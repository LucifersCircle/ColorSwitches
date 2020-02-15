#include "iDHColorSwitchesRootListController.h"

@implementation iDHColorSwitchesRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

@end
