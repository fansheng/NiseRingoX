//
//  SCShellsList.h
//  NiseRingo
//
//  Created by apple  on 13-2-5.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class SCGhostManager;

@interface SCShellsList : NSArrayController<NSTableViewDataSource>{
    SCGhostManager* ghostManager;
    NSMutableArray* list;
}


- (id)initWithSCGhostManager:(SCGhostManager *)gm;
-(void)setContent:(NSString *)ghostRoot;

@end
