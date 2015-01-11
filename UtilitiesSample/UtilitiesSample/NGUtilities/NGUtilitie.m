//
//  NGUtilite.m
//  NGGameKit
//
//  Created by Nitin Gupta on 24/02/14.
//  Copyright (c) 2014 Nitin Gupta. All rights reserved.
//

#import "NGUtilitie.h"

@implementation NGUtilitie

#pragma mark - TS to Date & Date To TS Methods
+(long) getTimeStampFromNSDateValue:(NSDate *)_aDate {
    NSTimeInterval _aTS = [_aDate timeIntervalSince1970];
    return (long)_aTS;
}

+(NSDate *) getNSDateFromTimeStampValue:(long)_aTS {
    NSDate *_date = [NSDate dateWithTimeIntervalSince1970:_aTS];
    return _date;
}

#pragma mark - Date/Time Utility methods
// This method used to get the event startDate and endDate with time.
+ (NSDate *) getDateWithTime:(NSDate *)date {
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [gregorian components:(NSHourCalendarUnit  | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:[NSDate date]];
    
    NSDateComponents *currentDateComponent = [gregorian components:(NSYearCalendarUnit  | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit  | NSMinuteCalendarUnit) fromDate:date];
    [currentDateComponent setHour:[dateComponents hour]];
    [currentDateComponent setMinute:[dateComponents minute]];
    
    NSDate *newDate = [gregorian dateFromComponents:currentDateComponent];
    
    return newDate;
}

// This method used to get the time difference
+ (NSInteger) getTimeDifferenceFromCurrentTime:(NSString *)firstTime {
    
    NSArray *timeArray = [firstTime componentsSeparatedByString:@":"];
    NSInteger hour = [timeArray[0] integerValue];
    NSInteger minute = [timeArray[1] integerValue];
    NSInteger totalSec = (hour * 60 *60) + (minute * 60);
    
    NSDateComponents *component = [[NSCalendar currentCalendar] components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:[NSDate date]];
    hour = [component hour];
    minute = [component minute];
    NSInteger currentTimeInSec = (hour * 60 *60) + (minute * 60);
    
    NSInteger difference = totalSec - currentTimeInSec;
    
    /*
     First time is 9:00 and current time is 13:30.
     As first time is less than current time, to get difference
     between these two timings, need to add 12 hr seconds.
     */
    if (totalSec < currentTimeInSec) {
        difference = abs((int)difference);
        difference += 60*60*12; // adding 12 hour seconds.
    }
    
    return difference;
}

+(NSInteger) getTimeDifferenceInDaysForStartDate:(NSDate *)startDate EndDate:(NSDate *)endDate {
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:0];
    
    NSInteger _aValue = [components day];
    gregorianCalendar = nil;
    NSLog(@"[components day] = %d",_aValue );
    return _aValue;
}

+ (NSString *) getTimeStringFromTimerValue:(int)seconds inFormat:(TimeFormat)timeFormat {
    
    NSString *timeString = nil;
    
    int days = seconds / 86400; //(60 * 60 * 24);
    seconds -= days * 86400;    //(60 * 60 * 24);
    int hours = seconds / 3600; //(60 * 60);
    seconds -= hours * 3600;    //(60 * 60);
    int minutes = seconds / 60;
    seconds %= 60;
    
    NSMutableString *daysString = [[NSMutableString alloc] init];
    if (days==1) {
        [daysString appendFormat:@"%d Day", days];
    } else if (days) {
        [daysString appendFormat:@"%d Days", days];
    }
    
    NSMutableString *hoursString = [[NSMutableString alloc] init];
    if (hours==1) {
        [hoursString appendFormat:@"%d Hr", hours];
    } else if (hours) {
        [hoursString appendFormat:@"%d Hrs", hours];
    }
    
    NSMutableString *minsString = [[NSMutableString alloc] init];
    if (minutes==1) {
        [minsString appendFormat:@"%d Min", minutes];
    } else if (minutes) {
        [minsString appendFormat:@"%d Mins", minutes];
    }
    
    NSMutableString *secsString = [[NSMutableString alloc] init];
    if (seconds==1) {
        [secsString appendFormat:@"%d Sec", seconds];
    } else if (seconds) {
        [secsString appendFormat:@"%d Secs", seconds];
    }
    
    switch (timeFormat) {
        case kDaysFormat:
            timeString = [NSString stringWithFormat:@"%@ %@ %@ %@", daysString, hoursString,minsString,secsString];
            break;
            
        case kDigitalFormat:
            timeString = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
            break;
            
        default:
            timeString = [NSString stringWithFormat:@"%02d:%02d:%02d:%02d",days, hours, minutes, seconds];
            break;
    }
    
    daysString = nil;
    hoursString = nil;
    minsString = nil;
    secsString = nil;
    
    return timeString;
}

#pragma mark - String to Date & Date To String Methods
+(NSString *) getStringFromNSDateValue:(NSDate *)_aDate dateformat:(NSString*)dateformat {
    NSDateFormatter *_dateFormat = [[NSDateFormatter alloc] init];
    [_dateFormat setDateFormat:dateformat];
    NSString *_dateStr = [_dateFormat stringFromDate:_aDate];
    _dateFormat = nil;
    return _dateStr;
}

+(NSDate *) getNSDateFromStringValue:(NSString *)_aString dateformat:(NSString*)dateformat {
    NSDateFormatter *_dateFormat = [[NSDateFormatter alloc] init];
    [_dateFormat setDateFormat:dateformat];
    NSDate *_date = [_dateFormat dateFromString:_aString];
    _dateFormat = nil;
    return _date;
}

#pragma mark - Owner Phone Numbers Methods
+ (NSString *) getOwnerPhoneNumber {
    extern NSString* CTSettingCopyMyPhoneNumber();
    NSString *_phoneNum = CTSettingCopyMyPhoneNumber();
    NSLog(@"Phone : %@", _phoneNum);
    if (!_phoneNum || ![_phoneNum length]) {
        _phoneNum = @"";
    }
    return _phoneNum;
}

#pragma mark - Navigation bar Attribute Methods
+ (void) setApperanceForNavigationController {
    NSDictionary *_aTextOptions = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIColor blackColor], NSForegroundColorAttributeName, nil];
    UIImage *navBackgroundImage = [UIImage imageNamed:@"header"];
    
    [[UINavigationBar appearance] setBackgroundImage:navBackgroundImage forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:_aTextOptions];
}

#pragma mark - Random Coordinates Generator
+ (NSArray *) randomCoordinatesGenerator:(int) numberOfCoordinates mapView:(MKMapView *)_mapView {
    MKCoordinateRegion visibleRegion = _mapView.region;
    visibleRegion.span.latitudeDelta *= 0.8;
    visibleRegion.span.longitudeDelta *= 0.8;
    
    numberOfCoordinates = MAX(0,numberOfCoordinates);
    NSMutableArray *coordinates = [[NSMutableArray alloc] initWithCapacity:numberOfCoordinates];
    for (int i = 0; i < numberOfCoordinates; i++) {
        
        // start with top left corner
        CLLocationDistance longitude = visibleRegion.center.longitude - visibleRegion.span.longitudeDelta/2.0;
        CLLocationDistance latitude  = visibleRegion.center.latitude + visibleRegion.span.latitudeDelta/2.0;
        
        // Get random coordinates within current map rect
        NSInteger max = NSIntegerMax;
        longitude += (arc4random()%max)/(CGFloat)max * visibleRegion.span.longitudeDelta;
        latitude  -= (arc4random()%max)/(CGFloat)max * visibleRegion.span.latitudeDelta;
        
        CLLocation *loc = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
        [coordinates addObject:loc];
        loc = nil;
    }
    return  coordinates;
}

#pragma mark - JSON Handler Methods
+ (NSString *) getJSONStringFromDictionary:(NSDictionary *)_aDict{
    return [[NSString alloc] initWithData:[NGUtilitie getJSONDataFromDictionary:_aDict] encoding:NSUTF8StringEncoding];
}

+(NSData *) getJSONDataFromDictionary:(NSDictionary *)_aDict {
    NSError* error = nil;
    NSData *result = [NSJSONSerialization dataWithJSONObject:_aDict options:kNilOptions error:&error];
    if (error != nil)  {
        return nil;
    }
    return result;
}

+(NSDictionary *) getDictionaryFromJSONData:(NSData *)responseData {
    NSError* error = nil;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    if (error != nil)  {
        kNSLogWithObjectDescription(error);
        return nil;
    }
    return result;
}

#pragma mark - UIDevice Addon
+(NSString *) getGlobalUDID {
    return [[UIDevice currentDevice] uniqueGlobalDeviceIdentifier];
}

+(BOOL) isDeviceJailBroken {
    return [[UIDevice currentDevice] isJailbroken];
}

#pragma mark - Place to KM Method
+(double) getDistanceInKMBetweenPlace1:(CLLocationCoordinate2D) place1 andPlace2:(CLLocationCoordinate2D) place2 {
    MKMapPoint  start, finish;
    start = MKMapPointForCoordinate(place1);
    finish = MKMapPointForCoordinate(place2);
    return MKMetersBetweenMapPoints(start, finish) / 1000;
}

+ (double) getDistanceValueForGeoCode:(NSString *) _locationStr andRefCLLocation:(CLLocation *)_refLocation {
    double distance = 0;
    if (_locationStr && [_locationStr length]) {
        CGPoint _location = CGPointFromString(_locationStr);
        CLLocationCoordinate2D place1 = CLLocationCoordinate2DMake(_location.x, _location.y);
        CLLocationCoordinate2D place2 = [_refLocation coordinate];
        distance = [NGUtilitie getDistanceInKMBetweenPlace1:place1 andPlace2:place2];
    }
    return distance;
}

#pragma mark - Validate Email ID
+(BOOL) isValidEmailID:(NSString *)_anID {
    NSString *emailRegex = @"[A-Z0-9a-z][A-Z0-9a-z._%+-]*@[A-Za-z0-9][A-Za-z0-9.-]*\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    NSRange aRange;
    if([emailTest evaluateWithObject:_anID]) {
        aRange = [_anID rangeOfString:@"." options:NSBackwardsSearch range:NSMakeRange(0, [_anID length])];
        int indexOfDot = (int)aRange.location;
        if(aRange.location != NSNotFound) {
            NSString *topLevelDomain = [_anID substringFromIndex:indexOfDot];
            topLevelDomain = [topLevelDomain lowercaseString];
            NSSet *NGTLD;
            NGTLD = [NSSet setWithObjects:@".aero", @".asia", @".biz", @".cat", @".com", @".coop", @".edu", @".gov", @".info", @".int", @".jobs", @".mil", @".mobi", @".museum", @".name", @".net", @".org", @".pro", @".tel", @".travel", @".ac", @".ad", @".ae", @".af", @".ag", @".ai", @".al", @".am", @".an", @".ao", @".aq", @".ar", @".as", @".at", @".au", @".aw", @".ax", @".az", @".ba", @".bb", @".bd", @".be", @".bf", @".bg", @".bh", @".bi", @".bj", @".bm", @".bn", @".bo", @".br", @".bs", @".bt", @".bv", @".bw", @".by", @".bz", @".ca", @".cc", @".cd", @".cf", @".cg", @".ch", @".ci", @".ck", @".cl", @".cm", @".cn", @".co", @".cr", @".cu", @".cv", @".cx", @".cy", @".cz", @".de", @".dj", @".dk", @".dm", @".do", @".dz", @".ec", @".ee", @".eg", @".er", @".es", @".et", @".eu", @".fi", @".fj", @".fk", @".fm", @".fo", @".fr", @".ga", @".gb", @".gd", @".ge", @".gf", @".gg", @".gh", @".gi", @".gl", @".gm", @".gn", @".gp", @".gq", @".gr", @".gs", @".gt", @".gu", @".gw", @".gy", @".hk", @".hm", @".hn", @".hr", @".ht", @".hu", @".id", @".ie", @" No", @".il", @".im", @".in", @".io", @".iq", @".ir", @".is", @".it", @".je", @".jm", @".jo", @".jp", @".ke", @".kg", @".kh", @".ki", @".km", @".kn", @".kp", @".kr", @".kw", @".ky", @".kz", @".la", @".lb", @".lc", @".li", @".lk", @".lr", @".ls", @".lt", @".lu", @".lv", @".ly", @".ma", @".mc", @".md", @".me", @".mg", @".mh", @".mk", @".ml", @".mm", @".mn", @".mo", @".mp", @".mq", @".mr", @".ms", @".mt", @".mu", @".mv", @".mw", @".mx", @".my", @".mz", @".na", @".nc", @".ne", @".nf", @".ng", @".ni", @".nl", @".no", @".np", @".nr", @".nu", @".nz", @".om", @".pa", @".pe", @".pf", @".pg", @".ph", @".pk", @".pl", @".pm", @".pn", @".pr", @".ps", @".pt", @".pw", @".py", @".qa", @".re", @".ro", @".rs", @".ru", @".rw", @".sa", @".sb", @".sc", @".sd", @".se", @".sg", @".sh", @".si", @".sj", @".sk", @".sl", @".sm", @".sn", @".so", @".sr", @".st", @".su", @".sv", @".sy", @".sz", @".tc", @".td", @".tf", @".tg", @".th", @".tj", @".tk", @".tl", @".tm", @".tn", @".to", @".tp", @".tr", @".tt", @".tv", @".tw", @".tz", @".ua", @".ug", @".uk", @".us", @".uy", @".uz", @".va", @".vc", @".ve", @".vg", @".vi", @".vn", @".vu", @".wf", @".ws", @".ye", @".yt", @".za", @".zm", @".zw", nil];
            if(topLevelDomain != nil && ([NGTLD containsObject:topLevelDomain])) {
                return TRUE;
            }
        }
    }
    return FALSE;
}

@end
