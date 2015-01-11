//
//  UIButton+NGAddOn.h
//  UtilitiesSample
//
//  Created by Nitin Gupta on 6/12/14.
//  Copyright (c) 2014 Nitin Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (NGAddOn)
@property (nonatomic, strong) NSMutableDictionary *actionsList;

- (void) setAction:(UIControlEvents)event withBlock:(void(^)())block;

@end
