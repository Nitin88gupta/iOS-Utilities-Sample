//
//  UITapGestureRecognizer+NGAddOn.h
//  SocialVideo
//
//  Created by Nitin Gupta on 6/13/14.
//  Copyright (c) 2014 Anand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITapGestureRecognizer (NGAddOn)
@property (nonatomic, strong) NSMutableDictionary *actionsList;

- (instancetype)initWithTarget:(id)target actionWithBlock:(void(^)())block;

@end
