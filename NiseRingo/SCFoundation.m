//
//  SCFoundation.m
//  NiseRingo
//
//  Created by apple  on 13-1-28.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCFoundation.h"
#import "SCSession.h"

/**************** GLOBAL SWITCHES *****************/
//static BOOL DEBUG_MODE=NO;
//static NSString *FIXED_GHOST_TO_BOOT=nil; // home/ghost/<name>
//static BOOL LOG_SHIORI_SESSION = NO; // ここをtrueにすれば全てのSHIORIが標準出力にログを吐く。
//static BOOL LOG_MAKOTO_SESSION = NO; // ここをtrueにすれば全てのMAKOTOが標準出力にログを吐く。
//static BOOL LOCK_SHIORI_EVENTS = NO; // ここをtrueにすればSHIORIにイベントが全く送られない。
//static BOOL DO_EXPLICIT_GC = true; // ここをfalseにすれば明示的なSystem.gc()が行われない。
//static BOOL LOAD_WHOLE_SURFACES_ON_BOOTING_SURFACE_SERVER = NO; // ここをtrueにすればサーフィスサーバーが起動時に全てのサーフィスをロードする。
//static BOOL STOP_SERIKO = NO; // ここをtrueにすればSERIKOアニメーションが動作しない。（起動中のアニメーションは止まらない。）
//static BOOL COMPRESS_SURFACES_ON_MEMORY = NO; // ここをtrueにすればSCSurfaceが画像をメモリ上で可逆圧縮する。
//static BOOL LOCK_BALLOONS = NO; // ここをtrueにすれば決して何も喋らない。
//static BOOL DO_NOT_BOOT_ANY_GHOSTS_AT_STARTUP = NO; // ここをtrueにすればアプリケーションの起動時にゴーストを起動しない。
//static BOOL SSTP_CONFLICT_IF_ANYONE_SPEAKING = true; // trueなら、SSTPで発話中のゴーストが一人でも居た場合に、SSTP SENDに409 Conflictを返す。
//static BOOL DO_NOT_DETERMINE_GHOST_DETAIL = NO; // trueなら、ゴーストマネージャが各ゴーストのSHIORIやMAKOTOを調べない。
//static BOOL BALLOON_USES_CLICK_THROUGH = NO; // trueなら、バルーンウインドウがクリックスルーを使う。
//static BOOL ACTIVATE_WINDOWS_WHEN_RUNNING_SCRIPT = true; // trueなら、スクリプト動作中、レベルがNormalWindowLevelの場合には、一時的にレベルを上げる。
///**************************************************/
//
///**************** GLOBAL CONSTANTS ****************/
//static NSString *STRING_FOR_SENDER = @"NiseRingo"; // 栞や真琴へ渡すSenderヘッダ
///**************************************************/


@implementation SCFoundation


+(SCFoundation *)sharedFoundation{
    static SCFoundation* _sharedInstance=nil;
    @synchronized(self)  {
        if  (_sharedInstance == nil) {
            _sharedInstance=[[self alloc] init]; // assignment not done here
        }
    }
    return _sharedInstance;
}

-(void)performQuit{
    //runSCAppQuitter
    [self performSelectorInBackground:@selector(runSCAppQuitter) withObject:nil];
}

-(void)runSCAppQuitter{
    [[NSApplication sharedApplication] terminate:nil];
    return;
}

-(NSString*)getParentDirOfBundle{
    NSString *parOfBundle=[[[NSBundle mainBundle] bundlePath] stringByDeletingLastPathComponent];
    return parOfBundle;
}

-(SCSession*)getSession
{
    // 起動中のセッションのうち、どれか一つを返します。
    // 一つも起動していなかったらnullを返します。
    if ([sessions count] == 0) return nil;
    
    int session_idx = (int)((random() * 10000) % [sessions count]);
    return (SCSession*)[sessions objectAtIndex:session_idx];
}

-(SCSession*)getSessionByPath:(NSString*)ghostPath{
    // 起動中のセッションの中から、ゴーストパスがghostPathであるセッションを探して返します。
    // 見つからなかったらnullを返します。
    SCSession *result = nil;
    NSInteger n_sessions =[sessions count];
    for (int i = 0;i < n_sessions;i++)
    {
        SCSession *s = (SCSession*)[sessions objectAtIndex:i];
        if ([[s ghostPath] isEqual:ghostPath])
        {
            result = s;
            break;
        }
    }
    return result;
}
-(SCSession *)openSessionByGhostPath:(NSString *)ghostPath ByBalloonPath:(NSString *)balloonPath{
    return [self openSessionByGhostPath:ghostPath ByBalloonPath:balloonPath ByScale:1.0];
}

-(SCSession *)openSessionByGhostPath:(NSString *)ghostPath ByBalloonPath:(NSString *)balloonPath ByScale:(NSInteger)scale{
    SCSession *session =[[SCSession alloc] initWithGhostPath:ghostPath BalloonPath:balloonPath];
    return session;
}

@end
