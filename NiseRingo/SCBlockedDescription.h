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

-(instancetype)initWithFilename:(NSString*) filename NS_DESIGNATED_INITIALIZER;
-(void)load:(NSString*) filename;
-(id)getObjectForKey:(NSString*)key;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSArray *allKeys;
@end
