//
//  SCBalloonsListElement.m
//  NiseRingo
//
//  Created by apple  on 13-4-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCBalloonsListElement.h"
#import "SCDescription.h"
#import "SCAlphaConverter.h"
#import "SCFoundation.h"

@implementation SCBalloonsListElement
@synthesize name;
@synthesize path;
@synthesize thumbnail;

-(instancetype)initWithPath:(NSString *)path1{
    path=path1;
    SCDescription *descm = [[SCDescription alloc] initWithFilename:[path stringByAppendingPathComponent:@"descript.txt"]];
    name=[descm getStrValue:@"name"];
    NSFileManager *sharedFM = [NSFileManager defaultManager];
    NSString *thumbnailFile = [path stringByAppendingPathComponent:@"thumbnail.png"];
    if ([sharedFM fileExistsAtPath:thumbnailFile]) {
		self.thumbnail = [SCAlphaConverter convertImage:[[NSImage alloc] initWithContentsOfFile:thumbnailFile]];
		// pnaが存在するか？
		NSString *pnaFile = [path stringByAppendingPathComponent:@"thumbnail.pna"];
		if ([sharedFM fileExistsAtPath:pnaFile]) {
		    // pnaをロードしてアルファチャンネルにコピー
		    NSImage *pna = [[NSImage alloc] initWithContentsOfFile:pnaFile];
            [SCAlphaConverter attachAlpha:pna toImage:thumbnail];
		}
    }
    else {
		thumbnailFile = [path stringByAppendingPathComponent:@"thumbnail.pnr"];
		if ([sharedFM fileExistsAtPath:thumbnailFile]) {
		    self.thumbnail = [SCAlphaConverter convertImage:[[NSImage alloc] initWithContentsOfFile:thumbnailFile]];
		}
		else {
		    self.thumbnail = nil;
		}
    }
     
    return self;
}

@end
