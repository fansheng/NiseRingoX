//
//  SCDescription.m
//  NiseRingo
//
//  Created by apple  on 13-2-18.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCDescription.h"

@implementation SCDescription
-(id)initWithFilename:(NSString *)filename{
    self=[super init];
    if (self) {
        [self load:filename];
    }
    return self;
}

-(void)load:(NSString *)filename{
    if (table==nil) {
        table=[[NSMutableDictionary alloc] init];
    }
    NSError *error;
    NSString *stringFromFile=[[NSString alloc]
                               initWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:&error];
    if (stringFromFile==nil) {
        stringFromFile=[[NSString alloc]
                        initWithContentsOfFile:filename encoding:[NSString defaultCStringEncoding] error:&error];
    }
    
    NSArray *arrayFile =[stringFromFile componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    for (NSString *s in arrayFile) {
        NSString* stringline=[s stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([stringline length]!=0 && ![stringline hasPrefix:@"//"] && ![stringline hasPrefix:@"#"])
        {
            NSRange range=[stringline rangeOfString:@","];
            if (range.location!=NSNotFound) {
                NSString* keystring=[stringline substringToIndex:range.location];
                NSString* valuestring=[stringline substringFromIndex:range.location+1];
                [table setValue:valuestring forKey:keystring];
                //NSLog(@"%@ %@",valuestring,keystring);
            }
        }
    }
}

-(NSString*)getStrValue:(NSString*)key{
    return [table objectForKey:key];
}

@end
