//
//  SCBalloonsListElement.h
//  NiseRingo
//
//  Created by apple  on 13-4-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SCBalloonsListElement : NSObject{
    NSString *name;
    NSString *path;
	NSImage *thumbnail;
}
@property (readwrite,copy)NSString* name;
@property (readwrite,copy)NSString* path;
@property (readwrite,retain)NSImage* thumbnail;

-(id)initWithPath:(NSString *)path;

@end
