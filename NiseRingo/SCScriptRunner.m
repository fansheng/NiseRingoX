//
//  SCScriptRunner.m
//  NiseRingo
//
//  Created by apple  on 13-4-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCScriptRunner.h"
#import "SCSafetyBalloonController.h"

@implementation SCScriptRunner
-(void)initWithSession:(SCSession *)s ByParam:(NSString *)param{
    session = s;
    script=[[NSString alloc] initWithString:param];
    [self runScriptRunner];

}
-(void)runScriptRunner{
    SCSafetyBalloonController* balloon=[[SCSafetyBalloonController alloc] init];
    [balloon showWindow:self];
    
    NSUInteger len=script.length;
    NSUInteger index=0;
    while (len>index) {
        unichar firstChar=[script characterAtIndex:index];
        if (firstChar=='\\') {
            index++;
            if (index>=len) {
                break;
            }
            unichar secondChar=[script characterAtIndex:index];
            if (secondChar=='\\' || secondChar=='%'){
                NSLog(@"%C",secondChar);
                index++;
            }
            else if (secondChar=='e'){
                break;
            }
            else if (secondChar=='a'){
                index++;
            }
            else if (secondChar=='-'){
                break;
            }
            else if (secondChar=='+'){
                index++;
            }
            else if (secondChar=='h'||secondChar=='0'){
                index++;
            }
            else if (secondChar=='u'||secondChar=='1'){
                index++;
            }
            else if (secondChar=='s'){
                index++;
                NSLog(@"%@",@"doSurfaceChanging");
                index=[self doSurfaceChanging:script ByIndex:index];
            }
            else{
                NSLog(@"%C",secondChar);
                index++;
            }
        }
        else{
            //NSLog(@"%C",firstChar);
            [balloon addChar:firstChar];
            index++;
        }
    }
}

-(NSUInteger)doSurfaceChanging:(NSString *)str ByIndex:(NSUInteger)index{
    NSUInteger len=str.length;
    if (index+2<len) {
        if ([str characterAtIndex:index]=='[') {
            NSRange range=[str rangeOfString:@"]"];
            if (range.location!=NSNotFound) {
                NSString* keystring=[str substringWithRange:NSMakeRange(index+1, range.location-index-1)];
                NSLog(@"%@",keystring);
                return range.location+1;
            }
        }
    }
    return index;
}

@end
