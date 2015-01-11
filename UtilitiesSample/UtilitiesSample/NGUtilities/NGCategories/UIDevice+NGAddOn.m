//
//  UIDevice+NGAddOn.m
//  NGGameKit
//
//  Created by Nitin Gupta on 24/02/14.
//  Copyright (c) 2014 Nitin Gupta. All rights reserved.
//

#import "UIDevice+NGAddOn.h"

@implementation UIDevice (NGAddOn)

- (NSString *) uniqueGlobalDeviceIdentifier {
    
    NSString *uniqueIdentifier = nil;
    BOOL result = [[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)];
    if (result) {
        uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    } else {
        CFUUIDRef theUUID = CFUUIDCreate(NULL);
        CFStringRef string = CFUUIDCreateString(NULL, theUUID);
        CFRelease(theUUID);
        uniqueIdentifier = (__bridge NSString *)string ;
    }
    return uniqueIdentifier;
}

- (BOOL)isJailbroken {
	BOOL jailbroken = NO;
	
	NSArray *jailbrokenPath = [NSArray arrayWithObjects:@"/Applications/Cydia.app",
							   @"/Applications/RockApp.app",
							   @"/Applications/Icy.app",
							   @"/usr/sbin/sshd",
							   @"/usr/bin/sshd",
							   @"/usr/libexec/sftp-server",
							   @"/Applications/WinterBoard.app",
							   @"/Applications/SBSettings.app",
							   @"/Applications/MxTube.app",
							   @"/Applications/IntelliScreen.app",
							   @"/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
							   @"/Applications/FakeCarrier.app",
							   @"/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
							   @"/private/var/lib/apt",
							   @"/Applications/blackra1n.app",
							   @"/private/var/stash",
							   @"/private/var/mobile/Library/SBSettings/Themes",
							   @"/System/Library/LaunchDaemons/com.ikey.bbot.plist",
							   @"/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
							   @"/private/var/tmp/cydia.log",
							   @"/private/var/lib/cydia", nil];
	
	for(NSString *string in jailbrokenPath) {
		if ([[NSFileManager defaultManager] fileExistsAtPath:string]) {
			jailbroken = YES;
			break;
		}
	}
	return jailbroken;
}

- (NSString *) deviceType {
    NSString *_aType = @"iPad";
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        _aType = @"iPhone";
    }
    return _aType;
}



@end
