//
//  SCScriptRunner.h
//  NiseRingo
//
//  Created by apple  on 13-4-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SCSession;
@interface SCScriptRunner : NSObject{
    SCSession *session;
    NSString* script;
}
-(void)initWithSession:(SCSession*)s
               ByParam:(NSString*)param;
-(void)runScriptRunner;
-(NSUInteger)doSurfaceChanging:(NSString*)str
                       ByIndex:(NSUInteger)index;
@end
