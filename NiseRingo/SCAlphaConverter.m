//
//  SCAlphaConverter.m
//  NiseRingo
//
//  Created by apple  on 13-4-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCAlphaConverter.h"

@implementation SCAlphaConverter

+(NSImage *)convertImage:(NSImage *)srcImage {
    // srcImageの左上の座標を透過色としてアルファチャンネルに展開し、NSImageを作成します。
    NSBitmapImageRep *srcBitmap,*destBitmap;
    unsigned char *srcData,*destData;
    unsigned char trR,trG,trB,trA;
    NSInteger spp,width,height,src_bytesPerRow,dst_bytesPerRow,sI,dI,x,y;
    NSImage *image;
    
    srcBitmap = [[srcImage representations] objectAtIndex:0];
    srcData = [srcBitmap bitmapData];
    trR = srcData[0];
    trG = srcData[1];
    trB = srcData[2];
    spp = [srcBitmap samplesPerPixel];
    width = [srcBitmap pixelsWide];
    height = [srcBitmap pixelsHigh];
    
    image = [[[NSImage alloc] init] autorelease];
    //image = [[NSImage alloc] init];
    destBitmap = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:NULL
                                                         pixelsWide:width
                                                         pixelsHigh:height
                                                      bitsPerSample:[srcBitmap bitsPerSample]
                                                    samplesPerPixel:4
                                                           hasAlpha:YES
                                                           isPlanar:NO
                                                     colorSpaceName:NSCalibratedRGBColorSpace
                                                        bytesPerRow:0
                                                       bitsPerPixel:0];
    [image addRepresentation:destBitmap];
    
    destData = [destBitmap bitmapData];
    [destBitmap release];
    
    src_bytesPerRow = [srcBitmap bytesPerRow];
    dst_bytesPerRow = [destBitmap bytesPerRow];
    
    switch ([srcBitmap samplesPerPixel]) {
        case	3:
            for (y = 0; y < height; y++) {
                sI = y * src_bytesPerRow;
                dI = y * dst_bytesPerRow;
                
                for (x = 0; x < width; x++) {
                    if (!(srcData[sI] == trR && srcData[sI + 1] == trG && srcData[sI + 2] == trB)) {
                        destData[dI    ] = srcData[sI    ];
                        destData[dI + 1] = srcData[sI + 1];
                        destData[dI + 2] = srcData[sI + 2];
                        destData[dI + 3] = 0xff;
                    }
                    else {
                        destData[dI    ] = 0x00; // red
                        destData[dI + 1] = 0x00; // green
                        destData[dI + 2] = 0x00; // blue
                        destData[dI + 3] = 0x00; // alpha
                    }
                    
                    sI += 3; dI += 4;
                }
            }
            break;
            
        case	4:
            trA = srcData[3];
            for (y = 0; y < height; y++) {
                sI = y * src_bytesPerRow;
                dI = y * dst_bytesPerRow;
                
                for (x = 0; x < width; x++) {
                    // 2002-04-03 toveta 32bitの場合はアルファチャンネルも含めて比較する必要がある。
                    if (!(srcData[sI] == trR && srcData[sI + 1] == trG && srcData[sI + 2] == trB && srcData[sI + 3] == trA)) {
                        destData[dI    ] = srcData[sI    ];
                        destData[dI + 1] = srcData[sI + 1];
                        destData[dI + 2] = srcData[sI + 2];
                        destData[dI + 3] = 0xff; // アルファチャンネルの本来の意味ではsrcData[sI+3];とすべきだが…
                    }
                    else {
                        destData[dI    ] = 0x00; // red
                        destData[dI + 1] = 0x00; // green
                        destData[dI + 2] = 0x00; // blue
                        destData[dI + 3] = 0x00; // alpha
                    }
                    
                    sI += 4; dI += 4;
                }
            }
            break;
    }
    
    return image;
}

+(void)attachAlpha:(NSImage *)src toImage:(NSImage *)dest {
    // グレイスケール画像のsrcをアルファチャンネルと見做してdestに設定します。
    // 双方の画像のサイズが一致していなかったりdestがアルファチャンネルを持っていなかったりすれば何もしません。
    // srcがグレイスケールでなかった場合の動作は保証されません。
    NSBitmapImageRep *srcBits,*destBits;
    unsigned char *srcData,*destData;
    NSInteger src_bytesPerRow,dst_bytesPerRow,sI,dI,x,y,width,height;
    
    if ([src size].width != [dest size].width || [src size].height != [dest size].height) {
        NSLog(@"SCAlphaConverter -attachAlpha:toImage: : Parameters were images which have different size.");
        return;
    }
    
    srcBits = [[src representations] objectAtIndex:0];
    destBits = [[dest representations] objectAtIndex:0];
    
    if ([destBits samplesPerPixel] != 4) {
        NSLog(@"SCAlphaConverter -attachAlpha:toImage: : Destination didn¥'t have alpha channel.");
        return;
    }
    
    // 2002-04-03 toveta 特殊なColorSpaceの場合、変換処理をかけます
    if(![ [ srcBits colorSpaceName ] isEqualToString:NSCalibratedRGBColorSpace ]) {
        NSImage *buffer=[ [NSImage alloc] initWithSize:[src size] ];
        //[ buffer setCacheMode: NSImageCacheNever ];
        [ buffer lockFocus ];
        [ src compositeToPoint:NSZeroPoint operation:NSCompositeCopy ];
        [ buffer unlockFocus ];
        srcBits = [ [ NSBitmapImageRep alloc ] initWithData:[ buffer TIFFRepresentation ] ];
        [ buffer release ];
    }
    
    srcData = [srcBits bitmapData];
    destData = [destBits bitmapData];
    
    width = [srcBits pixelsWide];
    height = [srcBits pixelsHigh];
    
    src_bytesPerRow = [srcBits bytesPerRow];
    dst_bytesPerRow = [destBits bytesPerRow];
    
    switch ([srcBits samplesPerPixel]) {
        case	3:
            for (y = 0; y < height; y++) {
                sI = y * src_bytesPerRow;
                dI = y * dst_bytesPerRow;
                
                for (x = 0; x < width; x++) {
                    destData[dI  ] *= srcData[sI] / 255.0;
                    destData[dI+1] *= srcData[sI] / 255.0;
                    destData[dI+2] *= srcData[sI] / 255.0;
                    destData[dI+3]  = srcData[sI]; // dest.A = src.R
                    
                    sI += 3; dI += 4;
                }
            }
            break;
            
        case	4:
            for (y = 0; y < height; y++) {
                sI = y * src_bytesPerRow;
                dI = y * dst_bytesPerRow;
                
                for (x = 0; x < width; x++) {
                    destData[dI    ] *= srcData[sI] / 255.0;
                    destData[dI + 1] *= srcData[sI] / 255.0;
                    destData[dI + 2] *= srcData[sI] / 255.0;
                    destData[dI + 3]  = srcData[sI]; // dest.A = src.R
                }
                
                sI += 4; dI += 4;
            }
            break;
    }
}
@end
