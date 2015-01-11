//
//  NSObject+AddOn.m
//  TEst
//
//  Created by Nitin Gupta on 13/05/14.
//  Copyright (c) 2014 Nitin Gupta. All rights reserved.
//

#import "NSObject+AddOn.h"

@implementation NSObject (AddOn)
- (NSString *)description_NG {
    return [NSString stringWithFormat:@"\nClass: %@ \nProperties: %@\n",[self class], [self allPropertyDetails]];
}

- (NSArray *)allPropertyNames
{
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    NSMutableArray *rv = [NSMutableArray array];
    
    unsigned i;
    for (i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        [rv addObject:name];
    }
    
    free(properties);
    
    return rv;
}

- (void *)pointerForPropertyNamed:(NSString *)name
{
    objc_property_t property = class_getProperty([self class], [name UTF8String]);
    
    const char *attr = property_getAttributes(property);
    const char *ivarName = strchr(attr, 'V') + 1;
    
    Ivar ivar = object_getInstanceVariable(self, ivarName, NULL);
    
    return (char *)self + ivar_getOffset(ivar);
}

- (NSDictionary *)allPropertyDetails {
    NSArray *propArray = [self allPropertyNames];
    if ([propArray count]) {
        NSMutableDictionary *m_detailDict = [NSMutableDictionary dictionaryWithCapacity:[propArray count]];
        id myValue;
        for (NSString *prop in propArray) {
            id addressPtr = [self pointerForPropertyNamed:prop];
            myValue = *(id *)addressPtr;
            [m_detailDict setValue:myValue forKey:prop];
        }
        return m_detailDict;
    } else {
        return nil;
    }
}

@end
