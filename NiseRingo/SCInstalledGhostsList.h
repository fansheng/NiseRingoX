//
//  SCInstalledGhostsList.h
//  NiseRingo
//
//  Created by apple  on 13-2-5.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class SCGhostManager;
@interface SCInstalledGhostsList : NSObject<NSTableViewDataSource,NSTableViewDelegate>{
    SCGhostManager* ghostManager;
    NSMutableArray* list;
    NSArray* sublist;
}

- (instancetype)initWithSCGhostManager:(SCGhostManager *)gm NS_DESIGNATED_INITIALIZER;
-(void)sortList;
-(void)findBoxUpdated:(NSString *)to_find;
-(void)changeScale:(double)scale
           AtIndex:(NSInteger)selected_row;
-(void)bootOrQuit:(NSInteger)selected_row;

// Notification Callback
-(void)onShellChangingBeginAndEnd:(NSNotification*)notification;
-(void)onNetworkUpdaterBeginAndEnd:(NSNotification*)notification;
-(void)onSessionClosingAndOpeningBeginAndEnd:(NSNotification*)notification;
-(void)onSessionEnteringAndLeavingPassiveMode:(NSNotification*)notification;


@end
