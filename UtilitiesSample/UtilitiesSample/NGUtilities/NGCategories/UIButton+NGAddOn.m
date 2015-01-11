//
//  UIButton+NGAddOn.m
//  UtilitiesSample
//
//  Created by Nitin Gupta on 6/12/14.
//  Copyright (c) 2014 Nitin Gupta. All rights reserved.
//

#import "UIButton+NGAddOn.h"
//#import "/usr/include/objc/runtime.h"
#import <objc/runtime.h>

static char aKey;

@implementation UIButton (NGAddOn)
@dynamic actionsList;

-(void)setAction:(UIControlEvents)event withBlock:(void (^)())block {
    if ([self actionsList] == nil) {
        [self setActions:[[NSMutableDictionary alloc] init]];
    }
    [[self actionsList] setObject:block forKey:[NSNumber numberWithInt:event]];
    
    switch (event) {
        case UIControlEventTouchDown: {
            [self addTarget:self action:@selector(doUIControlEventTouchDown:) forControlEvents:UIControlEventTouchDown];
        } break;
        case UIControlEventTouchDownRepeat: {
            [self addTarget:self action:@selector(doUIControlEventTouchDownRepeat:) forControlEvents:UIControlEventTouchDownRepeat];
        } break;
        case UIControlEventTouchDragInside: {
            [self addTarget:self action:@selector(doUIControlEventTouchDragInside:) forControlEvents:UIControlEventTouchDragInside];
        } break;
        case UIControlEventTouchDragOutside: {
            [self addTarget:self action:@selector(doUIControlEventTouchDragOutside:) forControlEvents:UIControlEventTouchDragOutside];
        } break;
            //
        case UIControlEventTouchDragEnter: {
            [self addTarget:self action:@selector(doUIControlEventTouchDragEnter:) forControlEvents:UIControlEventTouchDragEnter];

        } break;
        case UIControlEventTouchDragExit: {
            [self addTarget:self action:@selector(doUIControlEventTouchDragExit:) forControlEvents:UIControlEventTouchDragExit];

        } break;
        case UIControlEventTouchUpInside: {
            [self addTarget:self action:@selector(doUIControlEventTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];

        } break;
        case UIControlEventTouchUpOutside: {
            [self addTarget:self action:@selector(doUIControlEventTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];

        } break;
        case UIControlEventTouchCancel: {
            [self addTarget:self action:@selector(doUIControlEventTouchCancel:) forControlEvents:UIControlEventTouchCancel];

        } break;
        case UIControlEventValueChanged: {
            [self addTarget:self action:@selector(doUIControlEventValueChanged:) forControlEvents:UIControlEventValueChanged];
        } break;
        default:
            break;
    }
}

- (void)setActions:(NSMutableDictionary*)actions {
    objc_setAssociatedObject (self, &aKey,actions,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary*)actionsList {
    return objc_getAssociatedObject(self, &aKey);
}

- (void)doUIControlEventTouchDown:(id)sender {
    void(^block)();
    block = [[self actionsList] objectForKey:[NSNumber numberWithBool:UIControlEventTouchDown]];
    block();
}

- (void)doUIControlEventTouchDownRepeat:(id)sender {
    void(^block)();
    block = [[self actionsList] objectForKey:[NSNumber numberWithBool:UIControlEventTouchDownRepeat]];
    block();
}

- (void)doUIControlEventTouchDragInside:(id)sender {
    void(^block)();
    block = [[self actionsList] objectForKey:[NSNumber numberWithBool:UIControlEventTouchDragInside]];
    block();
}

- (void)doUIControlEventTouchDragOutside:(id)sender {
    void(^block)();
    block = [[self actionsList] objectForKey:[NSNumber numberWithBool:UIControlEventTouchDragOutside]];
    block();
}

- (void)doUIControlEventTouchDragEnter:(id)sender {
    void(^block)();
    block = [[self actionsList] objectForKey:[NSNumber numberWithBool:UIControlEventTouchDragEnter]];
    block();
}

- (void)doUIControlEventTouchDragExit:(id)sender {
    void(^block)();
    block = [[self actionsList] objectForKey:[NSNumber numberWithInt:UIControlEventTouchDragExit]];
    block();
}
- (void)doUIControlEventTouchUpInside:(id)sender {
    void(^block)();
    block = [[self actionsList] objectForKey:[NSNumber numberWithInt:UIControlEventTouchUpInside]];
    block();
}

- (void)doUIControlEventTouchUpOutside:(id)sender {
    void(^block)();
    block = [[self actionsList] objectForKey:[NSNumber numberWithInt:UIControlEventTouchUpOutside]];
    block();
}

- (void)doUIControlEventTouchCancel:(id)sender {
    void(^block)();
    block = [[self actionsList] objectForKey:[NSNumber numberWithInt:UIControlEventTouchCancel]];
    block();
}

- (void)doUIControlEventValueChanged:(id)sender {
    void(^block)();
    block = [[self actionsList] objectForKey:[NSNumber numberWithInt:UIControlEventValueChanged]];
    block();
}

@end
