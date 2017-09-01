//
//  SCBalloonSkinServer.m
//  NiseRingo
//
//  Created by apple  on 13-4-15.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCBalloonSkinServer.h"
#import "SCFoundation.h"
#import "SCAlphaConverter.h"

@implementation SCBalloonSkinServer
-(instancetype)initWithPath:(NSString *)dir_path{
    self = [super init];
    if (self) {
        // 存在しないパスを示すバルーンスキンサーバを作ろうとした場合、空のサーバーが生成されます。
        path=dir_path;
        NSString *dir=[[SCFoundation sharedFoundation].parentDirOfBundle stringByAppendingPathComponent:path];
        
        desc=[[SCDescription alloc] initWithFilename:[dir stringByAppendingPathComponent:@"descript.txt"]];
        name=[desc getStrValue:@"name"];
        
        NSString *sstpmarkerfile = [dir stringByAppendingPathComponent:@"sstp.png"];
        NSString *arrow0file = [dir stringByAppendingPathComponent:@"arrow0.png"];
        NSString *arrow1file = [dir stringByAppendingPathComponent:@"arrow1.png"];
        
        NSFileManager *sharedFM = [NSFileManager defaultManager];
        if ([sharedFM fileExistsAtPath:sstpmarkerfile]){
            sstpMarker=[SCAlphaConverter convertImage:[[NSImage alloc] initWithContentsOfFile:sstpmarkerfile]];
        }
        if ([sharedFM fileExistsAtPath:arrow0file]){
            arrow_up=[SCAlphaConverter convertImage:[[NSImage alloc] initWithContentsOfFile:arrow0file]];
        }
        if ([sharedFM fileExistsAtPath:arrow1file]){
            arrow_down=[SCAlphaConverter convertImage:[[NSImage alloc] initWithContentsOfFile:arrow1file]];
        }
    }
    return self;
}
@end
