//
//  SCSerikoLibrary.m
//  NiseRingo
//
//  Created by apple  on 13-4-13.
//  Copyright (c) 2013年 apple. All rights reserved.
//
/*
 SCSerikoLibrary
 全てのSERIKOシーケンス記述ファイルの中身を管理します。
 
 バージョンは次の通りです。
 0: SERIKO/1.0
 1: SERIKO/2.0
 */

#import "SCSerikoLibrary.h"
#import "SCShell.h"

@implementation SCSerikoLibrary
-(instancetype)initWithShell:(SCShell *)shell{
    self = [super init];
    if (self) {
        /*
        protected void loadFromComprehensiveDefinitions(SCShell shell) {
            
        全てのエントリについて、次のような動作を行います。
             
        エントリ名をエイリアスデータベースから逆引きして、見付かったらその通りに読み込みます。
        データベースに無かったらエントリが命名規則に従っているかどうかを調べて、
        従っていたら読み込みます。
        そうでないエントリは無視します。
        */
        SCBlockedDescription *compDef =shell.surfaceDescriptions;
        
        // versionを見る
        int version = 0;
        
        NSArray *descript=(NSArray *)[compDef getObjectForKey:@"descript"];
        if (descript!=nil) {
            for (NSString *line in descript) {
                NSError *error = NULL;
                NSString *regexExp=@"^version\\s*,\\s*(\\d+)$";
                NSRegularExpression *regex=[NSRegularExpression regularExpressionWithPattern:regexExp options:NSRegularExpressionCaseInsensitive error:&error];
                NSTextCheckingResult *match = [regex firstMatchInString:line
                                                                options:0
                                                                  range:NSMakeRange(0, line.length)];
                if (match) {
                    NSRange firstHalfRange = [match rangeAtIndex:1];
                    version=[line substringWithRange:firstHalfRange].intValue;
                    
                }

            }
        }
        
    }
    return self;
}

@end
