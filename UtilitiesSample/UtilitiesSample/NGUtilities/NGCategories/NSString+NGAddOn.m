//
//  NSString+NGAddOn.m
//  NGGameKit
//
//  Created by Nitin Gupta on 24/02/14.
//  Copyright (c) 2014 Nitin Gupta. All rights reserved.
//

#import "NSString+NGAddOn.h"

@implementation NSString (NGAddOn)

- (NSString*)encodedURLParameterString {
    NSString *result = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                            (__bridge CFStringRef)self,
                                                                                            NULL,
                                                                                            CFSTR(":/=,!$&'()*+;[]@#?|"),
                                                                                            kCFStringEncodingUTF8));
	return result;
}

- (NSString*)substringFrom:(NSInteger)a to:(NSInteger)b {
	NSRange r;
	r.location = a;
	r.length = b - a;
	return [self substringWithRange:r];
}

- (NSInteger)indexOf:(NSString*)substring from:(NSInteger)starts {
	NSRange r;
	r.location = starts;
	r.length = [self length] - r.location;
	
	NSRange index = [self rangeOfString:substring options:NSLiteralSearch range:r];
	if (index.location == NSNotFound) {
		return -1;
	}
	return index.location + index.length;
}

- (NSString*)trimForWhiteSpaceAndNewLine {
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)startsWith:(NSString*)s {
	if([self length] < [s length]) return NO;
	return [s isEqualToString:[self substringFrom:0 to:[s length]]];
}

- (BOOL)containsString:(NSString *)aString {
	NSRange range = [[self lowercaseString] rangeOfString:[aString lowercaseString]];
	return range.location != NSNotFound;
}

- (NSString *)encodedURLString {
	NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                             (CFStringRef)self,
                                                                                             NULL,                   // characters to leave unescaped (NULL = all escaped sequences are replaced)
                                                                                             CFSTR("?=&+"),          // legal URL characters to be escaped (NULL = all legal characters are replaced)
                                                                                             kCFStringEncodingUTF8)); // encoding
	return result;
}

- (NSString *)decodedURLString {
	NSString *result = (NSString*)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                            (CFStringRef)self,
                                                                                                            CFSTR(""),
                                                                                                            kCFStringEncodingUTF8));
	
	return result;
}

-(NSString *)removeQuotes {
	NSUInteger length = [self length];
	NSString *ret = self;
	if ([self characterAtIndex:0] == '"') {
		ret = [ret substringFromIndex:1];
	}
	if ([self characterAtIndex:length - 1] == '"') {
		ret = [ret substringToIndex:length - 2];
	}
	
	return ret;
}

+ (NSString *) stringFromInt:(int)_aIntValue {
    return [NSString stringWithFormat:@"%d",_aIntValue];
}

+ (NSString *) stringFromFloat:(float)_aFloatValue {
    return [NSString stringWithFormat:@"%f",_aFloatValue];
}

+ (NSString *) stringFromLong:(long)_aLongValue {
    return [NSString stringWithFormat:@"%ld",_aLongValue];
}

@end
