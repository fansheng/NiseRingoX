//
//  SCBlockedDescription.h
//  NiseRingo
//
//  Created by apple  on 13-4-6.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCBlockedDescription : NSObject{
    NSMutableDictionary* root;
}

-(id)initWithFilename:(NSString*) filename;
-(void)load:(NSString*) filename;
-(id)getObjectForKey:(NSString*)key;
-(NSArray *)allKeys;
@end
