//
//  SCSession.h
//  NiseRingo
//
//  Created by apple  on 13-1-31.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCShell.h"
#import "SCSpirit.h"
#import "SCBalloonSkinServer.h"

@interface SCSession : NSThread{
    SCShell *currentShell;
    SCSpirit *masterSpirit;
    
    SCBalloonSkinServer *balserver;
      
    NSString *ghostPath;
}
@property (readwrite,copy)NSString* ghostPath;

-(instancetype)initWithGhostPath:(NSString*)ghost_path
          ShelldirName:(NSString*)shelldir_name
           BalloonPath:(NSString*)balloon_path
             LightMode:(BOOL)light_mode NS_DESIGNATED_INITIALIZER;
-(instancetype)initWithGhostPath:(NSString*)ghost_path
           BalloonPath:(NSString*)balloon_path;
-(void)openShellByScope:(int)scope;
-(void)start;
-(void)runSession:(SCSession*)session;
-(void)putString:(NSString*)str;

@end
