//
//  NSString+NGAddOn.h
//  NGGameKit
//
//  Created by Nitin Gupta on 24/02/14.
//  Copyright (c) 2014 Nitin Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NGAddOn)

- (NSString*)encodedURLParameterString;

- (NSString*)substringFrom:(NSInteger)a to:(NSInteger)b ;

- (NSInteger)indexOf:(NSString*)substring from:(NSInteger)starts ;

- (NSString*)trimForWhiteSpaceAndNewLine ;

- (BOOL)startsWith:(NSString*)s ;

- (BOOL)containsString:(NSString *)aString;

- (NSString *)encodedURLString;

- (NSString *)decodedURLString;

- (NSString *)removeQuotes;

+ (NSString *) stringFromInt:(int)_aIntValue ;

+ (NSString *) stringFromFloat:(float)_aFloatValue ;

+ (NSString *) stringFromLong:(long)_aLongValue;

@end
