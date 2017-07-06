//
//  Misaka.h
//  Misaka
//
//  Created by apple  on 13-5-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Misaka : NSObject
+(BOOL)checkIfUsable:(NSString *)ghostDir;
+(NSString *)getModuleName;
-(void)initByURL:(NSURL *)ghostDir;
-(NSString *)request:(NSString *)req;
@end
