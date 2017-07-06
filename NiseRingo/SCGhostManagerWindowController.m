//
//  SCGhostManagerWindowController.m
//  NiseRingo
//
//  Created by apple  on 13-2-3.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCGhostManagerWindowController.h"
#import "SCGhostManager.h"

@implementation SCGhostManagerWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id)initWithSCGhostManager:(SCGhostManager *)s
{
    self = [super initWithWindowNibName:@"GhostManager"];
    if (self) {
        // Initialization code here.
        [[self window] setFrameAutosaveName:@"ghostmanager.frame"];
        
        // タブの復帰 恢复页签
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        id tab_id = [defaults objectForKey:@"ghostmanager.tabview_info.IdOflastSelectedTab"];
        if (tab_id != nil) {
            [[self tabviewInfo] selectTabViewItemWithIdentifier:tab_id];
        }
        
        // サムネイルドローワ表示状態の復歸 恢复预览图
        if ([defaults integerForKey:@"ghostmanager.drawer.thumbnail.visible"] != 0) {
            [[self btn_thumb_view] setIntValue:1];
            //drawer_thumbnail.open();
        }
        ghostManager=s;
        installedList=[[SCInstalledGhostsList alloc] initWithSCGhostManager:ghostManager];
        
        [self.tableInstalled setDataSource:installedList];
        [self.tableInstalled setDelegate:installedList];
    }
    
    return self;
}

-(void)showWindow:(id)sender{
    [super showWindow:sender];
	
    if ([[self btn_thumb_view] intValue] != 0) {
        [[self drawer_thumbnail] open]; // ドローワが開かない問題を回避するhack
        [[[[self drawer_thumbnail] contentView] window] display]; // ドローワが再描画されない問題を回避するhack
    }

}

#pragma mark delegate methods 
-(BOOL)windowShouldClose:(id)sender{
    // 状態をdefaultsに保存します。
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[[[self tabviewInfo] selectedTabViewItem] identifier] forKey:@"ghostmanager.tabview_info.IdOflastSelectedTab"];
    [defaults setInteger:[[self btn_thumb_view] integerValue] forKey:@"ghostmanager.drawer.thumbnail.visible"];
    
    [defaults synchronize];
    return YES; // falseを返せばクローズが食い止められる。
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (IBAction)findBoxUpdated:(id)sender {
    [installedList findBoxUpdated:[self.findBox stringValue]];
    [self.tableInstalled reloadData];
}

- (IBAction)tateKesi:(id)sender {
    // リストで選択されているゴーストの起動/終了をトグル
    NSInteger selected_row = [self.tableInstalled selectedRow];
    [installedList bootOrQuit:selected_row];
    [self.tableInstalled reloadData];
    //[[ghostManager installedList] tableViewSelectionDidChange:nil];
}

- (IBAction)networkupdate:(id)sender {
    //TODO:networkupdate
}

- (IBAction)vanish:(id)sender {
    //TODO:vanish
}

- (IBAction)reloadLists:(id)sender {
    /*FIXME:兼容旧式样
     SCOldTypeConverter.convertAll();
     SCOldBalloonConverter.convertAll();
     SCGhostThumbnailMover.moveAll();
     */
    [self.tableInstalled deselectAll:[ghostManager installedList]];
    [ghostManager reloadLists];
}

- (IBAction)sliderScale:(id)sender {
    NSString *value = [NSString stringWithFormat:@"%d%%",(int)[sender doubleValue]*100];
    [[self scaleIndicator] setStringValue:value];
}

@end
