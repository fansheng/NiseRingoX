//
//  SCShellWindowController.m
//  NiseRingo
//
//  Created by apple  on 13-4-2.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCShellWindowController.h"
#import "SCSurfaceServer.h"

@interface SCShellWindowController ()

@end

@implementation SCShellWindowController

- (instancetype)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (instancetype)initWithSession:(SCSession*)s
                Scope:(int)scope{
    self = [super initWithWindowNibName:@"ShellWindow"];
    if (self) {
        // Initialization code here.
        //[[self plugin_list] setDataSource:self];
        session=s;
        
        [self.window setFrameOrigin:NSMakePoint(self.window.frame.origin.x, 0)];
        [self.window setAutodisplay:YES];
    }
    
    return self;
}
-(void)changeSurface:(SCSurfaceServer *)sserver
           SurfaceID:(int)surfaceID{
    surface=[sserver findSurface:surfaceID];
    if (surface!=nil) {
        NSImage *image =surface.rawImage;
        if (image!=nil) {
            // 座標にbaseHorizLocを使用する事で、offsetを無視する。
            NSRect newrect = NSMakeRect(0, 0, image.size.width, image.size.height);
            [self.window setFrame:newrect display:NO];
            
            [self.view changeSurface:image];
        }
    }
    [self.view display];
    //[[self window] setHasShadow:NO];
    
}


@end
