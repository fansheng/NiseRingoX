//
//  SCSpirit.h
//  NiseRingo
//
//  Created by apple  on 13-4-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCDescription.h"

@class SCSession;
@interface SCSpirit : NSObject{
    SCSession *session;
    
    SCDescription *descManager;
    
    NSString *spiritRootDir;
    
    NSString *name;
    NSString *selfname;
    NSString *keroname;
}

-(id)initWithSession:(SCSession*)argSession
             Dirname:(NSString*)dirname;
@end
