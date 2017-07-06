//
//  SCSession.m
//  NiseRingo
//
//  Created by apple  on 13-1-31.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCSession.h"
#import "SCShell.h"
#import "SCShellWindowController.h"
#import "SCFoundation.h"
#import "SCScriptRunner.h"

@implementation SCSession
@synthesize ghostPath;
-(id)initWithGhostPath:(NSString*)ghost_path
          ShelldirName:(NSString*)shelldir_name
           BalloonPath:(NSString*)balloon_path
             LightMode:(BOOL)light_mode{
    self = [super init];
    if (self) {
        ghostPath=[[NSString alloc] initWithFormat:@"%@/%@",[[SCFoundation sharedFoundation] getParentDirOfBundle],ghost_path];
        
        // master spirit 起動
        masterSpirit = [[SCSpirit alloc] initWithSession:self Dirname:@"master"];
        
        // shell 起動
        currentShell = [[SCShell alloc] initWithSession:self Dirname:shelldir_name];
        //(this,shelldir_name != null ? shelldir_name : getShellDirName(),stat);
        //currentShell.start();
        [self openShellByScope:0];
        
        // バルーンサーバー起動
        balserver=[[SCBalloonSkinServer alloc] initWithPath:balloon_path];

    }
    return self;
}
-(id)initWithGhostPath:(NSString *)ghost_path BalloonPath:(NSString *)balloon_path{
    return [self initWithGhostPath:ghost_path ShelldirName:nil BalloonPath:balloon_path LightMode:NO];
}
-(void)openShellByScope:(int)scope{
    SCShellWindowController *swc = [[SCShellWindowController alloc] initWithSession:self Scope:0];
    [swc showWindow:nil];
    [swc changeSurface:[currentShell surfserver] SurfaceID:10];
    
    
    return;
}
-(void)start{
    NSThread* myThread = [[NSThread alloc] initWithTarget:self
                                                 selector:@selector(runSession:)
                                                   object:nil];
    [myThread start];  // Actually create the thread
}

-(void)runSession:(SCSession *)session{
    //[self performSelectorOnMainThread:@selector(openShellByScope:) withObject:0 waitUntilDone:NO];
    //[self openShellByScope:0];
    [[SCScriptRunner alloc] initWithSession:session ByParam:@"\\1\\s[110]抽hi-lite的时候、\\w9\\n为什么\\w9总是会被说\\w9\\n『老头样』啊。\\e"];
}

@end
