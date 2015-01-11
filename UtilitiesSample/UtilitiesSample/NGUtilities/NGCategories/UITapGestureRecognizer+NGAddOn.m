//
//  UITapGestureRecognizer+NGAddOn.m
//  SocialVideo
//
//  Created by Nitin Gupta on 6/13/14.
//  Copyright (c) 2014 Anand. All rights reserved.
//

#import "UITapGestureRecognizer+NGAddOn.h"
#import <objc/runtime.h>

static NSString *aKey;
static NSString *actionKey = @"Action";

@implementation UITapGestureRecognizer (NGAddOn)
@dynamic actionsList;

- (instancetype)initWithTarget:(id)target actionWithBlock:(void(^)())block {
    if([super init]) {
        if ([self actionsList] == nil) {
            [self setActionsList:[[NSMutableDictionary alloc] init]];
        }
        [[self actionsList] setObject:block forKey:actionKey];
        [self addTarget:target action:@selector(tapAction:)];
    }
    return self;
}

- (void)setActionsList:(NSMutableDictionary*)actions {
    objc_setAssociatedObject (self, &aKey,actions,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary*)actionsList {
    return objc_getAssociatedObject(self, &aKey);
}

- (void)tapAction:(id)sender {
    void(^block)();
    block = [[self actionsList] objectForKey:actionKey];
    block();
}

@end
