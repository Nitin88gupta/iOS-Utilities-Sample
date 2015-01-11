//
//  NGMacros.h
//  NGGameKit
//
//  Created by Nitin Gupta on 24/02/14.
//  Copyright (c) 2014 Nitin Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 Getting Application Delgate
 */
#define ApplicationDelegate                         ((AppDelegate *)[[UIApplication sharedApplication] delegate])

/*!
 Getting User Defaults
 */
#define UserDefaults                                    [NSUserDefaults standardUserDefaults]

/*!
 Getting Default Notification Center
 */
#define NotificationCenter                             [NSNotificationCenter defaultCenter]

/*!
 Getting Shared Application
 */
#define SharedApplication                             [UIApplication sharedApplication]

/*!
 Getting Main Bundle
 */
#define Bundle                                              [NSBundle mainBundle]

/*!
 Getting Main Screen
 */
#define MainScreen                                      [UIScreen mainScreen]

/*!
 Setting Show Network Activity Indicator
 */
#define ShowNetworkActivityIndicator()         [UIApplication sharedApplication].networkActivityIndicatorVisible = YES

/*!
 Setting Hide Network Activity Indicator
 */
#define HideNetworkActivityIndicator()          [UIApplication sharedApplication].networkActivityIndicatorVisible = NO

/*!
 Setting Network Activity Indicator Visible
 @param x - Could be YES/ NO any time
 */
#define NetworkActivityIndicatorVisible(x)      [UIApplication sharedApplication].networkActivityIndicatorVisible = x

/*!
 Getting Navigation Bar
 */
#define NavBar                                              self.navigationController.navigationBar

/*!
 Getting Tab Bar
 */
#define TabBar                                              self.tabBarController.tabBar

/*!
 Getting Navigation Bar Height
 */
#define NavBarHeight                                    self.navigationController.navigationBar.bounds.size.height

/*!
 Getting Tab Bar Height
 */
#define TabBarHeight                                    self.tabBarController.tabBar.bounds.size.height

/*!
 Getting UIScreen Width Reverse As Always Launch in Lanscape mode
 */
#define ScreenWidth                                     [[UIScreen mainScreen] bounds].size.height

/*!
 Getting UIScreen Height Reverse As Always Launch in Lanscape mode
 */
#define ScreenHeight                                    [[UIScreen mainScreen] bounds].size.width


#define ScreenMidPoint                                  CGPointMake(ScreenWidth / 2, ScreenHeight / 2)


#define TouchHeightDefault                           44

#define TouchHeightSmall                            32

/*!
 Getting View Width
 */
#define ViewWidth(v)                                    v.frame.size.width

/*!
 Getting View Height
 */
#define ViewHeight(v)                                   v.frame.size.height

/*!
 Getting View Origin X
 */
#define ViewX(v)                                          v.frame.origin.x

/*!
 Getting View Origin Y
 */
#define ViewY(v)                                          v.frame.origin.y

/*!
 Getting ViewController Width
 */
#define SelfViewWidth                                  self.view.bounds.size.width

/*!
 Getting ViewController Height
 */
#define SelfViewHeight                                 self.view.bounds.size.height

/*!
 Getting Rect X
 */
#define RectX(f)                                           f.origin.x

/*!
 Getting Rect Y
 */
#define RectY(f)                                            f.origin.y

/*!
 Getting Rect Width
 */
#define RectWidth(f)                                    f.size.width

/*!
 Getting Rect Height
 */
#define RectHeight(f)                                   f.size.height

/*!
 Setting Rect Width
 */
#define RectSetWidth(f, w)                          CGRectMake(RectX(f), RectY(f), w, RectHeight(f))

/*!
 Setting Rect Height
 */
#define RectSetHeight(f, h)                          CGRectMake(RectX(f), RectY(f), RectWidth(f), h)

/*!
 Setting Rect X
 */
#define RectSetX(f, x)                                  CGRectMake(x, RectY(f), RectWidth(f), RectHeight(f))

/*!
 Setting Rect Y
 */
#define RectSetY(f, y)                                  CGRectMake(RectX(f), y, RectWidth(f), RectHeight(f))

/*!
 Setting Rect Size
 */
#define RectSetSize(f, w, h)                        CGRectMake(RectX(f), RectY(f), w, h)

/*!
 Setting Rect Origin
 */
#define RectSetOrigin(f, x, y)                      CGRectMake(x, y, RectWidth(f), RectHeight(f))

/*!
 Date Component Value
 */
#define DATE_COMPONENTS                       NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit

/*!
 Time Component Value
 */
#define TIME_COMPONENTS                       NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit

/*!
 Flush Auto release pool.
 @param p- Pool to be flushed
 */
#define FlushPool(p)                                [p drain]; p = [[NSAutoreleasePool alloc] init]

/*!
 @param r - red value
 @param g- green Value
 @param b - blue value
 */
#define RGB(r, g, b)                                [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

/*!
 @param r - red value
 @param g- green Value
 @param b - blue value
 @param a- Alpha Value
 */
#define RGBA(r, g, b, a)                            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

/*!
 @param c - HexColor value
 @param a- Alpha Value
 */
#define HEXCOLOR(c,a)                              [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:a];

/*!
 NSLogs(...). with the current function
 */
#define kNSLogFunction     NSLog(@"%s",__FUNCTION__);
#define kNSLogObject(_object)     NSLog(@"%@",_object);
#define kNSLogWithObjectDescription(_object) NSLog(@"Function: %s Object Type:%@ Discription:%@ \nLine Number:%d", __FUNCTION__ , [_object class],[_object description], __LINE__);

/*!
 @param notificationName - The notification name
 @param obj - The notification object
 @param userInfoDictionary - The NSDictionary for the info
 */
#define notify(_notificationName, _obj, _userInfoDictionary) [[NSNotificationCenter defaultCenter] postNotificationName: _notificationName object: _obj userInfo: _userInfoDictionary];

/*!
 @param notificationName - The notification name
 @param observer - Observer adding to the NSNotificationCenter
 @param observerSelector - The selector for the notificaton
 */
#define addObserver(_notificationName, _observer, _observerSelector, _obj) [[NSNotificationCenter defaultCenter] addObserver:_observer selector:@selector(_observerSelector) name:_notificationName object: _obj];

/*!
 @param observer - Observer remove from the NSNotificationCenter
 */
#define removeObserver(_observer) [[NSNotificationCenter defaultCenter] removeObserver: _observer];

/*!
 Perform a code snippet on the main thread
 @aCodeSnippet - code snippet that shuld execute on the main thread
 */
#define onMainThread(_aCodeSnippet) \
if([NSThread isMainThread]){ \
_aCodeSnippet \
} else { \
dispatch_async(dispatchaet_main_queue(), ^{ \
_aCodeSnippet \
}); \
}

#define DECLARE_KEY( key ) FOUNDATION_EXPORT NSString *const key;
#define DEFINE_KEY( key ) NSString *const key = @ #key;
#define DEFINE_KEY_WITH_VALUE( key, property ) NSString *const key = @ #property;

/*!
 checks for the current device is an iPhone 5 or iPod Touch 5 Gen, or an Device with 1136 Screen height
 */
#define DEVICE_IS_IPHONE_5                              ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

/*!
 checks for the current device is an iPhone or iPod Touch
 */
#define DEVICE_IS_IPHONE                                                    ( UIUserInterfaceIdiomPhone == UI_USER_INTERFACE_IDIOM() )

/*!
 checks for the current device is an iPad
 */
#define DEVICE_IS_IPAD                                                      ( UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM())

/*!
 Check for the current version Number Equal to.
 */
#define SYSTEM_VERSION_EQUAL_TO(aVersion)                  ( floor(NSFoundationVersionNumber) == aVersion )

/*!
 Check for the current version Number Greater than.
 */
#define SYSTEM_VERSIONaREATER_THAN(aVersion)              ( floor(NSFoundationVersionNumber) >  aVersion )

/*!
 Check for the current version Number Greater than Equal.
 */
#define SYSTEM_VERSIONaREATER_THAN_OR_EQUAL_TO(aVersion)  ( floor(NSFoundationVersionNumber) >= aVersion )


/*!
 Check for the current version Number less than.
 */
#define SYSTEM_VERSION_LESS_THAN(aVersion)                 ( floor(NSFoundationVersionNumber) <  aVersion )


/*!
 Check for the current version Number less than equal to.
 */
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(aVersion)     ( floor(NSFoundationVersionNumber) <= aVersion )