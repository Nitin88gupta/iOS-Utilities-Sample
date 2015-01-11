//
//  NGViewController.m
//  UtilitiesSample
//
//  Created by Nitin Gupta on 16/04/14.
//  Copyright (c) 2014 Nitin Gupta. All rights reserved.
//

#import "NGViewController.h"
#import "NGUtilitie.h"
#import "NGFileHandler.h"
#import "NSString+NGAddOn.h"
#import "NSURL+NGAddOn.h"
#import "UIView+NGAddOn.h"
#import "UIButton+NGAddOn.h"
@interface
NGViewController ()

@end

@implementation NGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _aFileManger = [NGFileHandler sharedFileManager];
    
    [self blockButtonTest];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
#if !__has_feature(objc_arc)
    //Do manual memory management...
    _aFileManger = nil;
	[super dealloc];
#else
    //Usually do nothing...
    _aFileManger = nil;
#endif
}

#pragma mark - IBActions Related
- (IBAction)stringUtilitiesAction:(id)sender {
    kNSLogFunction;
    NSString *aString = @"https://www.google.co.in";
    NSLog(@"aString = %@ encodedURLParameterString= %@",aString,[aString encodedURLParameterString]);
    
    aString = @"Nitin Gupta";
    NSLog(@"aString = %@ substringFrom:to:= %@",aString,[aString substringFrom:1 to:5]);
    
    NSLog(@"aString = %@ indexOf (G):from: = %d",aString,[aString indexOf:@"G" from:0]);

    NSLog(@"aString = %@ trimForWhiteSpaceAndNewLine = %@",aString,[aString trimForWhiteSpaceAndNewLine]);

    NSLog(@"aString = %@ startsWith(BOOL) = %d",aString,[aString startsWith:@"p"]);

    NSLog(@"aString = %@ containsString(BOOL) = %d",aString,[aString containsString:@"p"]);
    
    NSLog(@"aString = %@ stringFromInt = %@",aString,[NSString stringFromInt:101]);

    NSLog(@"aString = %@ stringFromFloat = %@",aString,[NSString stringFromFloat:1.04567]);

    NSLog(@"aString = %@ stringFromFloat = %@",aString,[NSString stringFromFloat:3456789]);
    
}

- (IBAction)fileReadUtilitiesAction:(id)sender {
    kNSLogFunction;
    NSDictionary *_dict = [_aFileManger readFile:kSaved_Data_FileType isAsync:false outputType:kDictionary_OutputType];
    if (_dict) {
        NSLog(@"_dict = %@",_dict);
    } else {
        NSLog(@"kSaved_Data_FileType Reading File Failed");
    }
}

- (IBAction)fileWriteUtilitiesAction:(id)sender {
    kNSLogFunction;
    NSDictionary *_dict = [NSDictionary dictionaryWithObjectsAndKeys:@"Nitin",@"FirstName",@"Gupta",@"LastName",nil];
    BOOL _result = [_aFileManger saveFile:kSaved_Data_FileType For:_dict];
    if (_result) {
        NSLog(@"_result Saving File Success");
    } else {
        NSLog(@"_result Saving File Failed");
    }
}

- (IBAction)dateUtilitiesAction:(id)sender {
    kNSLogFunction;
    NSDate *orgDateVal = [NSDate date];
    
    long dateValTS = [NGUtilitie getTimeStampFromNSDateValue:orgDateVal];
    NSDate *dateRetVal = [NGUtilitie getNSDateFromTimeStampValue:dateValTS];
    
    NSLog(@"orgDateVal = %@",orgDateVal);
    NSLog(@"dateValTS = %lu, dateRetVal = %@",dateValTS,dateRetVal);
    
    NSString *dateString = [NGUtilitie getStringFromNSDateValue:orgDateVal dateformat:@"dd/MM/YYYY:HH:mm:SS"];
    NSLog(@"dateString = %@",dateString);
}

- (IBAction)jsonUtilitiesAction:(id)sender {
    kNSLogFunction;
    NSDictionary *_p1 = [NSDictionary dictionaryWithObjectsAndKeys:@"Nitin",@"FirstName",@"Gupta",@"LastName",nil];
    NSDictionary *_p2 = [NSDictionary dictionaryWithObjectsAndKeys:@"Sachin",@"FirstName",@"Gupta",@"LastName",nil];
    NSArray *_pArray = [NSArray arrayWithObjects:_p1,_p2, nil];
    
    NSDictionary *_dict = [NSDictionary dictionaryWithObjectsAndKeys:_pArray,@"personArray", nil];
    
    //Dictionary to Json String/Data Conversion
    NSString *jsonString = [NGUtilitie getJSONStringFromDictionary:_dict];
    NSData *jsonData = [NGUtilitie getJSONDataFromDictionary:_dict];
    NSLog(@"\njsonString = %@, \njsonData = %@",jsonString,jsonData);

    //Json String/ Data to Dictionary Conversion
    NSDictionary *retDataDict = [NGUtilitie getDictionaryFromJSONData:jsonData];
    NSDictionary *retStringDict = [NGUtilitie getDictionaryFromJSONData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"\nretDataDict = %@, \nretStringDict = %@",retDataDict,retStringDict);
}

- (IBAction)distanceUtilitiesAction:(id)sender {
    kNSLogFunction;
    CLLocationCoordinate2D _p1 = CLLocationCoordinate2DMake(100.0, 12.0);
    CLLocationCoordinate2D _p2 = CLLocationCoordinate2DMake(12.0, 102.0);

    NSLog(@"Distance = %f Km",[NGUtilitie getDistanceInKMBetweenPlace1:_p1 andPlace2:_p2]);
    
}

- (IBAction)emailUtilitiesAction:(id)sender {
    kNSLogFunction;
    //valid Example
    NSString *email = @"nitin88gupta@gmail.com";
    BOOL _result = [NGUtilitie isValidEmailID:email];
    if (_result) {
        NSLog(@"Valid Email (%@)",email);
    } else {
        NSLog(@"Invalid Email (%@)",email);
    }
   
    //Invalid Example
    email = @"nitin88gupta@gmail.cmo";
    _result = [NGUtilitie isValidEmailID:email];
    if (_result) {
        NSLog(@"Valid Email (%@)",email);
    } else {
        NSLog(@"Invalid Email (%@)",email);
    }
}

- (IBAction)viewUpdateUtilitiesAction:(id)sender {
    if ([viewRef isHidden]) {
        [viewRef setHidden:NO];
    }
    if (CGPointEqualToPoint(viewRef.frame.origin, CGPointZero)) {
        [viewRef setPosition:CGPointMake(100, 100)];
        [viewRef setSize:CGSizeMake(100, 100)];
    } else {
        [viewRef setPosition:CGPointZero];
        [viewRef setSize:self.view.frame.size];
    }
}

- (void)blockButtonTest {
    UIButton *_btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [_btn setAction:UIControlEventTouchUpInside withBlock:^{
        NSLog(@"Block : %s",__FUNCTION__);
    }];
    [_btn setTitle:@"Tap On Screen and Check Console For Block Action Response" forState:UIControlStateNormal];
    [_btn setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:_btn];
    [self.view bringSubviewToFront:_btn];
}
@end
