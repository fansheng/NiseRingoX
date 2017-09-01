//
//  SCShell.m
//  NiseRingo
//
//  Created by apple  on 13-4-5.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCShell.h"
#import "SCSession.h"

@implementation SCShell

@synthesize descManager;
@synthesize surfaceDescriptions;
@synthesize surfserver;
@synthesize shellRootDir;
-(instancetype)initWithSession:(SCSession*)argSession
             Dirname:(NSString*)argDirname{
    self = [super init];
    if (self) {
        session=argSession;
        
        NSLog(@"%@/shell/%@",session.ghostPath,argDirname);
        // Initialization code here.
        shellRootDir=[NSString stringWithFormat:@"%@/shell/%@",session.ghostPath,argDirname];
        descManager=[[SCDescription alloc] initWithFilename:[shellRootDir stringByAppendingPathComponent:@"descript.txt"]];
        shellname=[descManager getStrValue:@"name"];
        
        
        NSString *surfaces_txt=[shellRootDir stringByAppendingPathComponent:@"surfaces.txt"];
        NSFileManager *sharedFM = [NSFileManager defaultManager];
        if ([sharedFM fileExistsAtPath:surfaces_txt]){
            surfaceDescriptions=[[SCBlockedDescription alloc] initWithFilename:surfaces_txt];
        }
        
        selfname = [descManager getStrValue:@"sakura.name"];
        keroname = [descManager getStrValue:@"kero.name"];

        surfserver=[[SCSurfaceServer alloc] initWithShell:self];
        
        seriko=[[SCSeriko alloc] initWithShell:self];
    }
    
    return self;
}
@end
