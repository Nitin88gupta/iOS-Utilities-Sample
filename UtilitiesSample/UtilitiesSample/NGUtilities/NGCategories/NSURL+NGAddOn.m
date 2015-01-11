//
//  NSURL+NGAddOn.m
//  NGGameKit
//
//  Created by Nitin Gupta on 24/02/14.
//  Copyright (c) 2014 Nitin Gupta. All rights reserved.
//

#import "NSURL+NGAddOn.h"

@implementation NSURL (NGAddOn)

- (NSString *)URLStringWithoutQuery {
    NSArray *parts = [[self absoluteString] componentsSeparatedByString:@"?"];
    return [parts objectAtIndex:0];
}

@end
