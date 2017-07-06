//
//  SCInstalledBalloonsList.h
//  NiseRingo
//
//  Created by apple  on 13-2-5.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class SCGhostManager;

@interface SCInstalledBalloonsList : NSArrayController<NSTableViewDataSource>{
    SCGhostManager* ghostManager;
    NSMutableArray* list;
    int selected_item; // ラジオボタンで選択されている項目。0はbuilt-in。
    // ちなみに空欄のパスはbuilt-inを表します。

}

- (id)initWithSCGhostManager:(SCGhostManager *)gm;
-(void)setEnabled:(BOOL)boolflag;
-(void)selectBalloon:(NSString *)balloon_path;
-(void)reloadList;

-(int)getMaxHeightOfThumbnails;

@end
