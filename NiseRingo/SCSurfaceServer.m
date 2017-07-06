//
//  SCSurfaceServer.m
//  NiseRingo
//
//  Created by apple  on 13-4-14.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCSurfaceServer.h"
#import "SCShell.h"


@implementation SCSurfaceServer
-(id)initWithShell:(SCShell *)argShell{
    self = [super init];
    if (self) {
        shell=argShell;
        
        SCBlockedDescription *descriptions=[shell surfaceDescriptions];
        NSArray *keyArray=nil;
        if (descriptions!=nil) {
            keyArray=[descriptions allKeys];
        }
        for (NSString *alia in keyArray) {
            if ([alia hasPrefix:@"surface"]) {
                NSLog(@"%@",alia);
            }
        }
        
        surfaces=[[NSMutableDictionary alloc] init];
        
        NSFileManager *sharedFM = [NSFileManager defaultManager];
        NSURL *shelldir=[NSURL URLWithString:[shell shellRootDir]];
        NSDirectoryEnumerator *dirEnumerator = [sharedFM enumeratorAtURL:shelldir
                                                  includingPropertiesForKeys:[NSArray arrayWithObjects:NSURLNameKey,NSURLIsDirectoryKey,nil]
                                                                     options:NSDirectoryEnumerationSkipsSubdirectoryDescendants|NSDirectoryEnumerationSkipsHiddenFiles
                                                                errorHandler:nil];
        
        for (NSURL *theURL in dirEnumerator) {
            NSString *fileName;
            NSNumber *isDirectory;

            [theURL getResourceValue:&fileName forKey:NSURLNameKey error:NULL];
            [theURL getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:NULL];
            
            if ([isDirectory boolValue]==NO)
            {
                NSError *error = NULL;
                NSString *regexExp=@"^surface\\d+\\.(png|dgp)$";
                NSRegularExpression *regex=[NSRegularExpression regularExpressionWithPattern:regexExp options:NSRegularExpressionCaseInsensitive error:&error];
                NSUInteger numberOfMatches = [regex numberOfMatchesInString:fileName
                                                                    options:0
                                                                      range:NSMakeRange(0, [fileName length])];
                if (numberOfMatches==1) {
                    int surfaceID=[[fileName substringWithRange:NSMakeRange(7, [fileName length]-11)] intValue];
                    SCSurface *surface = [[SCSurface alloc] initWithFile:[[shell shellRootDir] stringByAppendingPathComponent:fileName] surfaceID:surfaceID Description:[shell surfaceDescriptions]];
                    NSNumber *value=[NSNumber numberWithInt:surfaceID];
                    [surfaces setObject:surface forKey:value];
                }
            }
        }
    }
    return self;
}
-(SCSurface*)findSurface:(int)surfaceID{
    NSNumber *value=[NSNumber numberWithInt:surfaceID];
    return [surfaces objectForKey:value];
}

@end
