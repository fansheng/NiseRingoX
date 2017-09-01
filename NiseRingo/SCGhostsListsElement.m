//
//  SCGhostsListsElement.m
//  NiseRingo
//
//  Created by apple  on 13-3-29.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCGhostsListsElement.h"
#import "SCDescription.h"

@implementation SCGhostsListsElement
@synthesize name;
@synthesize path;
@synthesize balloon_path;
@synthesize shell_dirname;
@synthesize scale;

-(instancetype)initWithBootFlag:(BOOL)boot_flag1
                 Path:(NSString *)path1
          BalloonPath:(NSString *)balloon_path1
         ShellDirname:(NSString *)shell_dirname1
                Scale:(double)scale1{
    bootFlag=boot_flag1;
    path=path1;
    self.balloon_path=balloon_path1;
    shell_dirname=shell_dirname1;
    scale=scale1;
    
    // 無駄な処理ではあるが、専用のコードは面倒で書きたくない。
    SCDescription *descm = [[SCDescription alloc] initWithFilename:[path stringByAppendingString:@"/ghost/master/descript.txt"]];

    name = [descm getStrValue:@"name"];
    selfname = [descm getStrValue:@"sakura.name"];
    keroname = [descm getStrValue:@"kero.name"];
    if (name == nil) {
        if (selfname != nil) {
            if (keroname != nil) {
                name = [NSString stringWithFormat:@"%@,%@",selfname,keroname];
            }
            else {
                name = selfname;
            }
        }
        else {
            name=@"unknow";
            //name = SCStringsServer.getStrFromMainDic("ghostmanager.ghostname.undefined");
        }
    }
    
    return self;
}

-(void)setBootFlag:(BOOL)bootFlag1{
    bootFlag=bootFlag1;
}

@end
