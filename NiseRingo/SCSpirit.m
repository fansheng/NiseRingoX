//
//  SCSpirit.m
//  NiseRingo
//
//  Created by apple  on 13-4-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCSpirit.h"
#import "SCSession.h"

@implementation SCSpirit
-(id)initWithSession:(SCSession*)argSession
             Dirname:(NSString*)argDirname{
    self = [super init];
    if (self) {
        session=argSession;
        spiritRootDir=[NSString stringWithFormat:@"%@/ghost/%@",[session ghostPath],argDirname];
        descManager=[[SCDescription alloc] initWithFilename:[spiritRootDir stringByAppendingPathComponent:@"descript.txt"]];
        
        name=[descManager getStrValue:@"name"];
        selfname = [descManager getStrValue:@"sakura.name"];
        keroname = [descManager getStrValue:@"kero.name"];
    }
    
    return self;
}

@end
