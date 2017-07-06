//
//  SCGhostsListsElement.h
//  NiseRingo
//
//  Created by apple  on 13-3-29.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCGhostsListsElement : NSObject{
    // あくまでSCInstalledGhostsListの内部クラスです。他のクラス内にある同名の物とは関係ありません。
    BOOL bootFlag;
    NSString *name;
    NSString *path;
    NSString *balloon_path;
    double scale;
    NSString *masterShioriKernelName; // これと
    NSArray *makotoNames; // これがnullなら、未判別である。
    NSString *identification;
    NSString *shell_dirname; // 最後に選ばれたシェルのディレクトリ名。
    NSString *selfname;
    NSString *keroname;
    
    BOOL thumb_checked; // サムネイルの有無を未判定ならfalse。
    NSString *thumb_file; // png又はpnr。無ければnull。
	
    // IDがghost/masterのものと異なるシェル一覧。
    BOOL indep_shells_checked; // 有無を未判定ならfalse。
    NSDictionary *independent_shells; // {ID => シェルディレクトリ名} 無ければnull
}
@property (readwrite,copy)NSString* name;
@property (readwrite,copy)NSString* path;
@property (readwrite,copy)NSString* balloon_path;
@property (readwrite,copy)NSString* shell_dirname;
@property (assign)double scale;

-(id)initWithBootFlag:(BOOL)boot_flag
                 Path:(NSString *)path
          BalloonPath:(NSString *)balloon_path
         ShellDirname:(NSString *)shell_dirname
                Scale:(double)scale;
-(void)setBootFlag:(BOOL)bootFlag;

@end
