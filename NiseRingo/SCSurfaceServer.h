//
//  SCSurfaceServer.h
//  NiseRingo
//
//  Created by apple  on 13-4-14.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCSurface.h"

// サーフィスの画像データその他をロードして、SCSurfaceを保持します。
@class SCShell;
@interface SCSurfaceServer : NSObject{
    SCShell *shell;
    NSMutableDictionary * surfaces; // key : (Integer)ID , value : (SCSurface)サーフィス
}
-(instancetype)initWithShell:(SCShell *)argShell NS_DESIGNATED_INITIALIZER;
-(SCSurface*)findSurface:(int)surfaceID;

@end
