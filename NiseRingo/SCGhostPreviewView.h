//
//  SCGhostPreviewView.h
//  NiseRingo
//
//  Created by apple  on 13-2-5.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SCGhostPreviewView : NSView{
    NSImage *background;
    NSImage *sakura,*kero;
    BOOL is_empty; // 通常、sakuraやkeroがnullの場合はその旨が「欠損」として報告されるが、これがtrueの時は「未選択」と解釈される。
    NSFont *messageFont;
    NSColor *messageColor;
    NSColor *messageBGColor;
}
@property (strong) NSColor *messageBGColor;

-(void)setImage:(NSString *)shell_dir;
-(void)setImage:(NSString *)pngFile
        byScope:(int)scope;

@end
