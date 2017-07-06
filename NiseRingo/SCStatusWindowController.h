//
//  SCStatusWindowController.h
//  NiseRingo
//
//  Created by apple  on 13-7-10.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SCStatusProgressBarView.h"
#import "SCStatusTextView.h"

@interface SCStatusWindowController : NSWindowController
@property (assign) IBOutlet SCStatusTextView *view_text_textview;
@property (assign) IBOutlet SCStatusProgressBarView *view_pbar_view;
-(void)setTypeToText;
-(void)setTypeToProgressBar;
-(void)texttypePrint:(NSString *)str;

@end
