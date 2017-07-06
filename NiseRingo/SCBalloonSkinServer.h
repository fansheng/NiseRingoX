//
//  SCBalloonSkinServer.h
//  NiseRingo
//
//  Created by apple  on 13-4-15.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCDescription.h"

@interface SCBalloonSkinServer : NSObject{
    NSString *path;
    NSString *name;
    SCDescription *desc;
    NSImage *sstpMarker;
    NSImage *arrow_up,*arrow_down;
}
-(id)initWithPath:(NSString *)dir_path;
@end
