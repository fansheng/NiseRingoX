//
//  SCShellsListElement.m
//  NiseRingo
//
//  Created by apple  on 13-5-5.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCShellsListElement.h"
#import "SCDescription.h"

@implementation SCShellsListElement
@synthesize name;
@synthesize path;

-(id)initWithPath:(NSString *)path1{
    path=path1;
    SCDescription *descm = [[SCDescription alloc] initWithFilename:[path stringByAppendingPathComponent:@"descript.txt"]];
    name=[descm getStrValue:@"name"];
    
    return self;
}

@end
