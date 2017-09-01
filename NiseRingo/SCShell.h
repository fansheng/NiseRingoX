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
@property (strong) SCDescription *descManager;
@property (strong) SCBlockedDescription *surfaceDescriptions;
@property (strong) SCSurfaceServer *surfserver;
@property (readwrite,copy) NSString *shellRootDir;

-(instancetype)initWithSession:(SCSession*)argSession
             Dirname:(NSString*)dirname NS_DESIGNATED_INITIALIZER;

@end
