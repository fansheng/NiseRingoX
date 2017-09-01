//
//  SCDescription.h
//  NiseRingo
//
//  Created by apple  on 13-2-18.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCDescription : NSObject{
    NSMutableDictionary* table;
}

-(instancetype)initWithFilename:(NSString*) filename NS_DESIGNATED_INITIALIZER;
-(void)load:(NSString*) filename;
-(NSString*)getStrValue:(NSString*)key;

@end
