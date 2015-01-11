//
//  UIDevice+NGAddOn.h
//  NGGameKit
//
//  Created by Nitin Gupta on 24/02/14.
//  Copyright (c) 2014 Nitin Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (NGAddOn)

- (NSString *) uniqueGlobalDeviceIdentifier ;

- (BOOL) isJailbroken ;

- (NSString *) deviceType ;

@end
