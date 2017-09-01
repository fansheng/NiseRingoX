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
    NSImage *__weak rawImage; // ここがnullの時は圧縮されたNSImageがcompressedImageに入っている。
    NSData *compressedImage;
    int surfaceID;
}
@property (weak) NSImage *rawImage;
@property (assign) int surfaceID;

-(instancetype)initWithFile:(NSString*)f
        surfaceID:(int)surfaceID
      Description:(SCBlockedDescription*)comprehensiveDefinitions NS_DESIGNATED_INITIALIZER;


@end
