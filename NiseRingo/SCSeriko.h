//
//  SCSeriko.h
//  NiseRingo
//
//  Created by apple  on 13-4-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//
/*
 SCSeriko
 
 SERIKOの全ての動作の管理を行います。
 */

#import <Foundation/Foundation.h>
#import "SCSerikoLibrary.h"

@class SCShell;
@interface SCSeriko : NSObject{
    SCSerikoLibrary *seriko_lib;
    SCShell *shell;
}
-(instancetype)initWithShell:(SCShell *)shell NS_DESIGNATED_INITIALIZER;

@end
