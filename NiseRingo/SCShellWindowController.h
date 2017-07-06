//
//  SCShellWindowController.h
//  NiseRingo
//
//  Created by apple  on 13-4-2.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SCShellView.h"

@class SCSession;
@class SCSurface;
@class SCSurfaceServer;
@interface SCShellWindowController : NSWindowController{
    SCSession *session;
    SCSurface *surface;
}

@property (assign) IBOutlet SCShellView *view;
- (id)initWithSession:(SCSession*)s
                Scope:(int)scope;
-(void)changeSurface:(SCSurfaceServer *)sserver
           SurfaceID:(int)surfaceID;
- (IBAction)changeImage:(id)sender;

@end
