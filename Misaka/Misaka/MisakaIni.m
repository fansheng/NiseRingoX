//
//  MisakaIni.m
//  Misaka
//
//  Created by apple  on 13-5-28.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "MisakaIni.h"

@implementation MisakaIni
-(id)initWithFilename:(NSString *)filename{
    self=[super init];
    if (self) {
        root=[[NSMutableDictionary alloc] init];
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
            if ([stringline length]==0 || [stringline hasPrefix:@"//"] || [stringline hasPrefix:@"#"]){
                continue;
            }
            if ([stringline hasPrefix:@"{"] && !IsInAilas) {
                if ([defaultAilas count]==0) {
                    continue;
                }
                IsInAilas=YES;
                ailasname=[[NSString alloc] initWithString:[defaultAilas lastObject]];
                [defaultAilas removeLastObject];
                ailasArray=[[NSMutableArray alloc] init];
                continue;
            }
            if (!IsInAilas) {
                [defaultAilas addObject:stringline];
                continue;
            }
            if ([stringline hasPrefix:@"}"]) {
                [root setObject:ailasArray forKey:ailasname];
                IsInAilas=NO;
                ailasname=nil;
                ailasArray=nil;
                continue;
            }
            [ailasArray addObject:stringline];
        }
        if (IsInAilas && ailasname!=nil && ailasArray!=nil) {
            [root setObject:ailasArray forKey:ailasname];
            IsInAilas=NO;
            ailasname=nil;
            ailasArray=nil;
        }
        if([defaultAilas count]!=0){
            [root setObject:defaultAilas forKey:@""];
            for (NSString* defaultAilasLine in defaultAilas) {
                NSRange range=[defaultAilasLine rangeOfString:@","];
                if (range.location!=NSNotFound) {
                    NSString* keystring=[stringline substringToIndex:range.location];
                    NSString* valuestring=[stringline substringFromIndex:range.location+1];
                    [root setValue:valuestring forKey:keystring];
                }
            }
        }
    }
    return self;
}

-(id)getObjectForKey:(NSString*)key{
    if (root!=nil) {
        return [root objectForKey:key];
    }
    return nil;
}

@end
