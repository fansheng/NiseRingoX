//
//  SCGhostManager.h
//  NiseRingo
//
//  Created by apple  on 13-2-3.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCGhostManagerWindowController.h"
#import "SCInstalledGhostsList.h"
#import "SCInstalledBalloonsList.h"
#import "SCShellsList.h"

@interface SCGhostManager : NSObject{
    SCGhostManagerWindowController* __weak windowController;
    SCInstalledGhostsList *__weak installedList;
    SCInstalledBalloonsList *__weak balloonsList;
    SCShellsList *shellsList;
    NSMutableArray* installedGhostList;
}
@property (weak) SCGhostManagerWindowController* windowController;
@property (weak) SCInstalledGhostsList *installedList;
@property (weak) SCInstalledBalloonsList *balloonsList;
@property (weak) SCShellsList *shellsList;
@property  NSMutableArray* installedGhostList; 

+(SCGhostManager *)sharedSCGhostManager;
-(void)reloadLists;
-(void)reloadinstalledGhostList;
-(void)ghostWillReload:(NSNotification *)notification;

-(NSMutableDictionary*)ghostDefaults:(NSString*)path;

@end
