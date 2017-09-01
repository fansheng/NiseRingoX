//
//  SCStatusWindowController.m
//  NiseRingo
//
//  Created by apple  on 13-7-10.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCStatusWindowController.h"

@interface SCStatusWindowController ()

@end

@implementation SCStatusWindowController


-(instancetype)initWithWindowNibName:(NSString *)windowNibName
{
    self=[super initWithWindowNibName:windowNibName];
    if (self) {
        // Initialization code here.
        self.view_text_textview=[[SCStatusTextView alloc] initWithFrame:self.window.frame];
        self.view_pbar_view=[[SCStatusProgressBarView alloc] initWithFrame:self.window.frame];
        
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

-(void)setTypeToText
{
    self.window.contentView = self.view_text_textview;
    //[[self window] display];
    //[[self view_text_textview] display];
}

-(void)setTypeToProgressBar
{
    self.window.contentView = self.view_pbar_view;
}

-(void)texttypePrint:(NSString *)str
{
    [self.view_text_textview printstr:str];
}
@end
