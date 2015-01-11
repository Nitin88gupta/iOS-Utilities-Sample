//
//  NGViewController.h
//  UtilitiesSample
//
//  Created by Nitin Gupta on 16/04/14.
//  Copyright (c) 2014 Nitin Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NGFileHandler;

@interface NGViewController : UIViewController {
    NGFileHandler *_aFileManger;
    __weak IBOutlet UIView *viewRef;
}

//IBActions Related
- (IBAction)stringUtilitiesAction:(id)sender;
- (IBAction)fileReadUtilitiesAction:(id)sender;
- (IBAction)fileWriteUtilitiesAction:(id)sender;
- (IBAction)dateUtilitiesAction:(id)sender;
- (IBAction)jsonUtilitiesAction:(id)sender;
- (IBAction)distanceUtilitiesAction:(id)sender;
- (IBAction)emailUtilitiesAction:(id)sender;
- (IBAction)viewUpdateUtilitiesAction:(id)sender;

@end
