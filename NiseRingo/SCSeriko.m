//
//  SCSeriko.m
//  NiseRingo
//
//  Created by apple  on 13-4-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCSeriko.h"

@implementation SCSeriko
-(id)initWithShell:(SCShell *)argShell{
    self = [super init];
    if (self) {
        shell=argShell;
        
        seriko_lib=[[SCSerikoLibrary alloc] initWithShell:argShell];
    }
    return self;
}

@end
