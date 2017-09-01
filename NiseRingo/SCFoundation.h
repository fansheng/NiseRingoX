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
@property (NS_NONATOMIC_IOSONLY, getter=getParentDirOfBundle, readonly, copy) NSString *parentDirOfBundle;
@property (NS_NONATOMIC_IOSONLY, getter=getSession, readonly, strong) SCSession *session;
-(SCSession*)getSessionByPath:(NSString*)ghostPath;
-(SCSession*)openSessionByGhostPath:(NSString*)ghostPath
                      ByBalloonPath:(NSString*)balloonPath
                            ByScale:(NSInteger)scale;
-(SCSession*)openSessionByGhostPath:(NSString*)ghostPath
                      ByBalloonPath:(NSString*)balloonPath;
@end
