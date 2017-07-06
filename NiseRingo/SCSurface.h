//
//  SCSurface.h
//  NiseRingo
//
//  Created by apple  on 13-4-14.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCBlockedDescription.h"
/*
 一枚のサーフィスを表すクラスです。
 サーフィスはpngデータ、〜s.txt、〜a.datファイルを持ちます。
 */
@interface SCSurface : NSObject{
    NSImage *rawImage; // ここがnullの時は圧縮されたNSImageがcompressedImageに入っている。
    NSData *compressedImage;
    int surfaceID;
}
@property (assign) NSImage *rawImage;
@property (assign) int surfaceID;

-(id)initWithFile:(NSString*)f
        surfaceID:(int)surfaceID
      Description:(SCBlockedDescription*)comprehensiveDefinitions;


@end
