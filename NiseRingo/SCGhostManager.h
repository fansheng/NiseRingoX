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
    SCGhostManagerWindowController* windowController;
    SCInstalledGhostsList *installedList;
    SCInstalledBalloonsList *balloonsList;
    SCShellsList *shellsList;
    NSMutableArray* installedGhostList;
}
@property (assign) SCGhostManagerWindowController* windowController;
@property (assign) SCInstalledGhostsList *installedList;
@property (assign) SCInstalledBalloonsList *balloonsList;
@property (assign) SCShellsList *shellsList;
@property (assign) NSMutableArray* installedGhostList; 

+(SCGhostManager *)sharedSCGhostManager;
-(void)reloadLists;
-(void)reloadinstalledGhostList;
-(void)ghostWillReload:(NSNotification *)notification;

-(NSMutableDictionary*)ghostDefaults:(NSString*)path;

@end
