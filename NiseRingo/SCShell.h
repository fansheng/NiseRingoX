//
//  SCShell.h
//  NiseRingo
//
//  Created by apple  on 13-4-5.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCDescription.h"
#import "SCBlockedDescription.h"
#import "SCSurfaceServer.h"
#import "SCSeriko.h"

@class SCSession;
@interface SCShell : NSObject{
    SCSession *session;
    SCDescription *descManager;
    SCSeriko *seriko;
    SCBlockedDescription *surfaceDescriptions; // surfaces.txtが存在しなければnullになっている。
    SCSurfaceServer *surfserver;
    
    NSString *shellRootDir;
    
    NSString *shellname;
    NSString *selfname;
    NSString *keroname;
}
@property (retain) SCDescription *descManager;
@property (retain) SCBlockedDescription *surfaceDescriptions;
@property (retain) SCSurfaceServer *surfserver;
@property (readwrite,copy) NSString *shellRootDir;

-(id)initWithSession:(SCSession*)argSession
             Dirname:(NSString*)dirname;

@end
