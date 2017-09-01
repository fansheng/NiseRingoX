//
//  SCInstalledGhostsList.m
//  NiseRingo
//
//  Created by apple  on 13-2-5.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCInstalledGhostsList.h"
#import "SCGhostManager.h"
#import "SCGhostManagerWindowController.h"
#import "SCFoundation.h"
#import "SCGhostsListsElement.h"
#import "SCSession.h"
#import "SCShellsListElement.h"

@implementation SCInstalledGhostsList

-(instancetype)initWithSCGhostManager:(SCGhostManager *)gm{
    self = [super init];
    if (self) {
        ghostManager=gm;
        
        //list = [[NSMutableArray alloc] init];
        list=gm.installedGhostList;
        sublist = [[NSArray alloc] initWithArray:list];
        //[self reloadList];
        /*
        [self tableViewSelectionDidChange:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onShellChangingBeginAndEnd:) name:@"shellchanger" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNetworkUpdaterBeginAndEnd:) name:@"networkupdater" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSessionClosingAndOpeningBeginAndEnd:) name:@"sessionstarter" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSessionClosingAndOpeningBeginAndEnd:) name:@"sessionchanger" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSessionClosingAndOpeningBeginAndEnd:) name:@"sessioncloser" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSessionClosingAndOpeningBeginAndEnd:) name:@"vanisher" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onSessionEnteringAndLeavingPassiveMode:) name:@"passivemode" object:nil];
         */
    }
    return self;
}

-(void)sortList{
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [list sortUsingDescriptors:@[sort]];
}

-(void)findBoxUpdated:(NSString *)to_find{
    // find_boxが空だった場合は、単にlistをsublistにコピー。
    // 空でなかった場合、ゴースト名に部分一致でfind_boxの内容を含んでいるものだけをsublistへ。
	
    if (to_find.length == 0) {
        sublist=[[NSArray alloc] initWithArray:list];
    }
    else {
        NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"name CONTAINS %@", to_find];
        sublist=[[NSArray alloc] initWithArray:[list filteredArrayUsingPredicate:filterPredicate]];
    }
	
    [self sortList];    
    
}

-(void)changeScale:(double)scale
           AtIndex:(NSInteger)selected_row{
    // 現在リストで選択されているゴーストのスケールを変える。
	
    if (scale == 0) {
        // 0にすると戻らなくなる恐れがあるので、しない。
        return;
    }
	
//    SCGhostManagerWindowController *windowController = [ghostManager windowController];
//    NSInteger selected_row = [[windowController tableInstalled] selectedRow];
    if (selected_row == -1) return;
    
    SCGhostsListsElement *elem = (SCGhostsListsElement*)sublist[selected_row];
    elem.scale=scale;
    
    // defaultsに保存
    NSMutableDictionary *ghostDefaults = [ghostManager ghostDefaults:elem.path];
    NSNumber *scaleValue=@(scale);
    ghostDefaults[@"scale"] = scaleValue;
    [ghostManager ghostDefaults:elem.path];
    
    // そのゴーストが起動していたら、ここでスケール変更。
    SCSession *session = [[SCFoundation sharedFoundation] getSessionByPath:elem.path];
    if (session != nil) {
        //session.resizeShell(scale);
    }
    return;
}

-(void)bootOrQuit:(NSInteger)selected_row{
        // リストで選択されているゴーストの起動/終了をトグル
        if (selected_row == -1) return;
        
        SCGhostsListsElement *elem = (SCGhostsListsElement*)sublist[selected_row];
        
        SCSession *session = [[SCFoundation sharedFoundation] getSessionByPath:elem.path];
        if (session == nil) {
            // 起動
            [elem setBootFlag:YES];
            //session=[[SCFoundation sharedFoundation] openSessionByGhostPath:[elem path] ByBalloonPath:nil];
            session=[[SCSession alloc] initWithGhostPath:elem.path ShelldirName:elem.shell_dirname BalloonPath:nil LightMode:NO];
            [session start];
            //SCSessionStarter.sharedStarter().start(elem.getPath(),elem.getBalloonPath(),elem.getScale());
        }
        else {
            // 終了
            [elem setBootFlag:NO];
            //session.performClose();
        }
        //ghostManager.setBootFlagInDefaults(elem.getPath(),elem.getBootFlag());
}

#pragma mark Notification Callback
-(void)onShellChangingBeginAndEnd:(NSNotification *)notification{
    ;
}

-(void)onNetworkUpdaterBeginAndEnd:(NSNotification *)notification{
    ;
}

-(void)onSessionClosingAndOpeningBeginAndEnd:(NSNotification *)notification{
    ;
}

-(void)onSessionEnteringAndLeavingPassiveMode:(NSNotification *)notification{
    ;
}

#pragma mark Delegete of NSTableView
-(BOOL)tableView:(NSTableView *)tableView shouldSelectTableColumn:(NSTableColumn *)tableColumn{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSString *old_key = [defaults stringForKey:@"ghostmanager.ghostlist.sort.key"];
    NSString *new_key = tableColumn.identifier;
    if ([new_key isEqual:old_key]) {
        // キーが同じなので順序を逆に。
        NSString *old_order = [defaults stringForKey:@"ghostmanager.ghostlist.sort.order"];
        NSString *new_order = [old_order isEqual:@"asc"] ? @"desc" : @"asc";
        [defaults setObject:new_order forKey:@"ghostmanager.ghostlist.sort.order"];
    }
    else {
        // キーが違ふ。新しい順序は常に昇順。
        [defaults setObject:new_key forKey:@"ghostmanager.ghostlist.sort.key"];
        [defaults setObject:@"asc" forKey:@"ghostmanager.ghostlist.sort.order"];
    }
    [defaults synchronize];
    //sortList();
    return NO;
}

-(void)tableViewSelectionDidChange:(NSNotification *)notification{
    // notificationは無視
    SCGhostManagerWindowController *windowController = ghostManager.windowController;
    
    NSInteger selected_row = windowController.tableInstalled.selectedRow;
    if (selected_row == -1) {
/*        windowController.getPreviewView().setEmpty();
	    
        windowController.setMasterShioriKernelName("-");
        windowController.setMakotoName("-");
        windowController.setIdentification("-");
        
        ghostManager.getBalloonsList().setEnabled(false);
        ghostManager.getShellsList().setEnabled(false);
        windowController.getScaleSlider().setEnabled(false);
        windowController.getScaleIndicator().setEnabled(false);
        windowController.setNumberOfShells(-1);
        
        // 初めて呼ばれた時のためにインジケータを初期化
        windowController.updateScaleIndicator();
	    
        windowController.setEnabledOfNetworkUpdateButton(false);
        windowController.setEnabledOfVanishButton(false);
        windowController.getBootAndQuitButton().setTitle(SCStringsServer.getStrFromMainDic("ghostmanager.bootandquit.boot")); // 立てる
        windowController.getBootAndQuitButton().setEnabled(false);
	    
        windowController.setThumbnail(null);*/
    }
    else{
        SCGhostsListsElement *le=sublist[selected_row];
        NSString *shell_dir =[NSString stringWithFormat:@"%@/%@/shell/%@",[SCFoundation sharedFoundation].parentDirOfBundle,le.path,le.shell_dirname];
        [windowController.previewView setImage:shell_dir];
        
        //TODO:
        
        // バルーン
        SCInstalledBalloonsList *bl = ghostManager.balloonsList;
        [bl setEnabled:YES];
        //[bl selectBalloon:[le balloon_path]];
        
        // シェル
        [ghostManager.shellsList setContent:le.path];
    }
/*    else {
        ListsElement le = (ListsElement)sublist.elementAt(selected_row);
        SCSession sessionIfRunning = SCFoundation.sharedFoundation().getSession(le.getPath()); // 起動していなければnull。
        boolean session_is_now_booting = SCSessionStarter.sharedStarter().isThisGhostStartingNow(le.getPath());
	    
        File shell_dir = new File(SCFoundation.sharedFoundation().getParentDirOfBundle(),le.getPath()+"/shell/"+le.getShellDirName());
        windowController.getPreviewView().setImage(shell_dir);
	    
        String masterShioriType = le.getMasterShioriKernelName();
        if (masterShioriType == null) {
            masterShioriType = SCStringsServer.getStrFromMainDic("ghostmanager.undeterminated");
        }
        else if (masterShioriType.length() == 0) {
            masterShioriType = SCStringsServer.getStrFromMainDic("ghostmanager.shioritype.none");
        }
        windowController.setMasterShioriKernelName( masterShioriType );
        windowController.setIdentification( le.getIdentification() );
	    
        Vector makoto_mod_names = le.getMakotoNames();
        String makotoName;
        if (makoto_mod_names == null) {
            makotoName = SCStringsServer.getStrFromMainDic("ghostmanager.undeterminated");
        }
        else if (makoto_mod_names.size() == 0) {
            makotoName = "¥u7121¥u3057"; // 無し
        }
        else {
            StringBuffer buf = new StringBuffer();
            final int n_makoto = makoto_mod_names.size();
            for (int i = 0;i < n_makoto;i++) {
                String name = (String)makoto_mod_names.elementAt(i);
                buf.append(name.length() == 0 ? SCStringsServer.getStrFromMainDic("ghostmanager.makototype.unknown") : name+", ");
            }
            makotoName = buf.toString();
        }
        windowController.setMakotoName(makotoName);
        
        // バルーン
        SCInstalledBalloonsList bl = ghostManager.getBalloonsList();
        bl.setEnabled(true);
        bl.selectBalloon( le.getBalloonPath() );
	    
        // スケール
        NSSlider scaleSlider = ghostManager.getWindowController().getScaleSlider();
        scaleSlider.setEnabled(true);
        scaleSlider.setDoubleValue( le.getScale() );
	    
        // インジケータに反映させる。
        ghostManager.getWindowController().updateScaleIndicator();
	    
        // シェル
        if (sessionIfRunning != null) {
            boolean onoff = (!sessionIfRunning.isShellChangingSessionRunningNow() &&
                             !sessionIfRunning.isStatusClosing() &&
                             !sessionIfRunning.isNetworkUpdaterRunningNow() &&
                             !sessionIfRunning.isInPassiveMode());
            ghostManager.getShellsList().setEnabled(onoff);
        }
        else {
            ghostManager.getShellsList().setEnabled(!session_is_now_booting);
        }
        ghostManager.getShellsList().setContent(le.getPath());
        ghostManager.getShellsList().selectShell(le.getShellDirName());
        windowController.setNumberOfShells(windowController.getTableShells().numberOfRows());
	    
        // サムネイル
        File thumbnailFile = le.getThumbnailFile();
        if (thumbnailFile != null) {
            NSImage thumbnail = null;
            String lowercase_fname = thumbnailFile.getName().toLowerCase();
            if (lowercase_fname.endsWith(".png")) {
                thumbnail = new NSImage(thumbnailFile.getPath(), true);
            }
            else if (lowercase_fname.endsWith(".pnr")) {
                thumbnail = SCAlphaConverter.convertImage(
                                                          new NSImage(thumbnailFile.getPath(), true));
            }
            windowController.setThumbnail(thumbnail);
        }
        else {
            windowController.setThumbnail(null);
        }
	    
        // ネットワーク更新,立て/消し
        if (sessionIfRunning == null) {
            windowController.setEnabledOfNetworkUpdateButton(false);
            windowController.setEnabledOfVanishButton(false);
            
            windowController.getBootAndQuitButton().setTitle(SCStringsServer.getStrFromMainDic("ghostmanager.bootandquit.boot"));
            windowController.getBootAndQuitButton().setEnabled(!session_is_now_booting);
        }
        else {
            windowController.getBootAndQuitButton().setTitle(SCStringsServer.getStrFromMainDic("ghostmanager.bootandquit.quit"));
            windowController.getBootAndQuitButton().setEnabled(
                                                               !sessionIfRunning.isStatusClosing() &&
                                                               !sessionIfRunning.isNetworkUpdaterRunningNow() &&
                                                               !sessionIfRunning.isInPassiveMode());
            windowController.setEnabledOfNetworkUpdateButton(
                                                             sessionIfRunning.getStringFromShiori("homeurl") != null &&
                                                             !sessionIfRunning.isNetworkUpdaterRunningNow() &&
                                                             !sessionIfRunning.isStatusClosing() &&
                                                             !sessionIfRunning.isInPassiveMode());
            NSUserDefaults defaults = NSUserDefaults.standardUserDefaults();
            windowController.setEnabledOfVanishButton(
                                                      (defaults.integerForKey("misc.always_show_vanish") == 1 ||
                                                       sessionIfRunning.getStringFromShiori("vanishbuttonvisible") == null ||
                                                       !sessionIfRunning.getStringFromShiori("vanishbuttonvisible").equals("0")) &&
                                                      !sessionIfRunning.isStatusClosing() &&
                                                      !sessionIfRunning.isNetworkUpdaterRunningNow() &&
                                                      !sessionIfRunning.isInPassiveMode());
        }
    }
*/
}

#pragma mark implementaion of NSTableView.DataSource
-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    if (sublist==nil) {
        return  0;
    }
    return sublist.count;
}

-(BOOL)tableView:(NSTableView *)tableView acceptDrop:(id<NSDraggingInfo>)info row:(NSInteger)row dropOperation:(NSTableViewDropOperation)dropOperation{
    return NO;
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)rowIndex{
    NSString *column_id=tableColumn.identifier;
    SCGhostsListsElement *elem=(SCGhostsListsElement*)sublist[rowIndex];
    if ([column_id isEqual:@"name"]) {
        //NSMutableAttributedString *mas=[[NSMutableAttributedString alloc] initWithString:[elem name]];
        //mas.addAttributeInRange(NSAttributedString.ForegroundColorAttributeName,BOOTED_COLOR,new NSRange(0,elem.getName().length()));
        return elem.name;
    }
    return nil;
}


@end
