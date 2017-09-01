//
//  SCBlockedDescription.m
//  NiseRingo
//
//  Created by apple  on 13-4-6.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCBlockedDescription.h"

@implementation SCBlockedDescription
-(instancetype)initWithFilename:(NSString *)filename{
    self=[super init];
    if (self) {
        [self load:filename];
    }
    return self;
}

-(void)load:(NSString *)filename{
    if (root==nil) {
        root=[[NSMutableDictionary alloc] init];
    }
    NSError *error;
    NSString *stringFromFile=[[NSString alloc]
                              initWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:&error];
    if (stringFromFile==nil) {
        stringFromFile=[[NSString alloc]
                        initWithContentsOfFile:filename encoding:[NSString defaultCStringEncoding] error:&error];
    }
    NSArray *arrayFile =[stringFromFile componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    NSMutableArray* defaultAilas=[[NSMutableArray alloc] init];
    BOOL IsInAilas=NO;
    NSString *ailasname=nil;
    NSMutableArray* ailasArray=nil;
    
    for (NSString *s in arrayFile) {
        NSString* stringline=[s stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        // 空の行は無視 コメント行は無視
        if (stringline.length==0 || [stringline hasPrefix:@"//"] || [stringline hasPrefix:@"#"]){
            continue;
        }
        if ([stringline hasPrefix:@"{"] && !IsInAilas) {
            if (defaultAilas.count==0) {
                continue;
            }
            IsInAilas=YES;
            ailasname=[[NSString alloc] initWithString:defaultAilas.lastObject];
            [defaultAilas removeLastObject];
            ailasArray=[[NSMutableArray alloc] init];
            continue;
        }
        if (!IsInAilas) {
            [defaultAilas addObject:stringline];
            continue;
        }
        if ([stringline hasPrefix:@"}"]) {
            root[ailasname] = ailasArray;
            IsInAilas=NO;
            ailasname=nil;
            ailasArray=nil;
            continue;
        }
        [ailasArray addObject:stringline];
    }
    if (IsInAilas && ailasname!=nil && ailasArray!=nil) {
        root[ailasname] = ailasArray;
        IsInAilas=NO;
        ailasname=nil;
        ailasArray=nil;
    }
    if(defaultAilas.count!=0){
        root[@""] = defaultAilas;
    }
}

-(id)getObjectForKey:(NSString*)key{
    if (root!=nil) {
        return root[key];
    }
    return nil;
}

-(NSArray *)allKeys{
    return root.allKeys;
}

@end
