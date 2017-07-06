//
//  SCFoundation.h
//  NiseRingo
//
//  Created by apple  on 13-1-28.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SCSession;
@interface SCFoundation : NSObject{
    NSMutableArray *sessions; // 中身はSCSession。
}

+(SCFoundation*)sharedFoundation;
-(void)performQuit;
-(void)runSCAppQuitter;
-(NSString*)getParentDirOfBundle;
-(SCSession*)getSession;
-(SCSession*)getSessionByPath:(NSString*)ghostPath;
-(SCSession*)openSessionByGhostPath:(NSString*)ghostPath
                      ByBalloonPath:(NSString*)balloonPath
                            ByScale:(NSInteger)scale;
-(SCSession*)openSessionByGhostPath:(NSString*)ghostPath
                      ByBalloonPath:(NSString*)balloonPath;
@end
