//
//  SCShellsListElement.h
//  NiseRingo
//
//  Created by apple  on 13-5-5.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCShellsListElement : NSObject{
NSString *name;
NSString *path;
}
@property (readwrite,copy)NSString* name;
@property (readwrite,copy)NSString* path;

-(instancetype)initWithPath:(NSString *)path;
@end
