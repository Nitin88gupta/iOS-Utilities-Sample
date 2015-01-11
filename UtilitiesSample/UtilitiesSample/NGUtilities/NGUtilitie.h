//
//  NGUtilite.h
//  NGGameKit
//
//  Created by Nitin Gupta on 24/02/14.
//  Copyright (c) 2014 Nitin Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CLLocationManager.h>
#import "UIDevice+NGAddOn.h"
#import "NGEnum.h"
#import "NGMacros.h"
#import "NGContants.h"

/*! NOTE: Add CoreLocation & MapKit Framwork to your Project 
 This Class Is Written For ARC Project Please Check all Allocation Before using in an non ARC project 
 or Keep this class ARC enabled by using -fobjc-arc in project settings.
 */


@interface NGUtilitie : NSObject

#pragma mark - TS to Date & Date To TS Methods
/*! Getting TS From NSDate Value*/
+(long) getTimeStampFromNSDateValue:(NSDate *)_aDate;

/*! Getting NSDate From TS Value*/
+(NSDate *) getNSDateFromTimeStampValue:(long)_aTS;

#pragma mark - Date/Time Utility methods
// This method used to get the event startDate and endDate with time.
+ (NSDate *) getDateWithTime:(NSDate *)date;

// This method used to get the time difference
+ (NSInteger) getTimeDifferenceFromCurrentTime:(NSString *)firstTime;

// This Method use to get Time Diff in Days
+(NSInteger) getTimeDifferenceInDaysForStartDate:(NSDate *)startDate EndDate:(NSDate *)endDate ;

/*! Getting Time String For Value in Seconds*/
+ (NSString *) getTimeStringFromTimerValue:(int)seconds inFormat:(TimeFormat)timeFormat;

#pragma mark - String to Date & Date To String Methods
/*! Getting NSString From NSDate Value*/
+(NSString *) getStringFromNSDateValue:(NSDate *)_aDate dateformat:(NSString*)dateformat;

/*! Getting NSDate From NSString Value*/
+(NSDate *) getNSDateFromStringValue:(NSString *)_aString dateformat:(NSString*)dateformat;

#pragma mark - Owner Phone Numbers Methods
+ (NSString *) getOwnerPhoneNumber;

#pragma mark - Navigation bar Attribute Methods
+ (void) setApperanceForNavigationController;


#pragma mark - Random Coordinates Generator
+ (NSArray *)randomCoordinatesGenerator:(int) numberOfCoordinates mapView:(MKMapView *)_mapView;

#pragma mark - JSON Handler Methods
+ (NSString *) getJSONStringFromDictionary:(NSDictionary *)_aDict;

+(NSData *) getJSONDataFromDictionary:(NSDictionary *)_aDict ;

+(NSDictionary *) getDictionaryFromJSONData:(NSData *)responseData;


#pragma mark - UIDevice Addon
/*! Global ID For User */
+(NSString *) getGlobalUDID ;

/*! Device Jail Broken Check*/
+(BOOL) isDeviceJailBroken;

#pragma mark - Place to KM Method
+(double) getDistanceInKMBetweenPlace1:(CLLocationCoordinate2D) place1 andPlace2:(CLLocationCoordinate2D) place2;

+ (double) getDistanceValueForGeoCode:(NSString *) _locationStr andRefCLLocation:(CLLocation *)_refLocation ;

#pragma mark - Validate Email ID
+(BOOL) isValidEmailID:(NSString *)_anID;

@end
