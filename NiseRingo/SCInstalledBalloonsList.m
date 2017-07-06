//
//  SCInstalledBalloonsList.m
//  NiseRingo
//
//  Created by apple  on 13-2-5.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCInstalledBalloonsList.h"
#import "SCGhostManager.h"
#import "SCFoundation.h"
#import "SCBalloonsListElement.h"

@implementation SCInstalledBalloonsList

-(id)initWithSCGhostManager:(SCGhostManager *)gm{
    self = [super init];
    if (self) {
        selected_item = 0;
        
        ghostManager=gm;
        
        NSTableView *tableBalloon = [[ghostManager windowController] tableBalloon];
        [tableBalloon setDataSource:self];
        /*
        NSButtonCell *bc=[[NSButtonCell alloc] init];
        [bc setButtonType:NSRadioButton];
        [bc setTitle:@""];
        NSTableColumn *tc=[tableView tableColumnWithIdentifier:@"select"];
        if (tc==nil) {
            NSLog(@"CInstalledBalloonsList error : The table doesn't have a NSTableColumn named [select].");
        }
        [tc setDataCell:bc];
        
        NSImageCell *ic = [[NSImageCell alloc] init];
        [ic setImageAlignment:NSImageAlignLeft];
        [ic setImageFrameStyle:NSImageFrameNone];
        [ic setImageScaling:NSImageScaleNone];
        NSTableColumn *thumbnail_tc =[tableView tableColumnWithIdentifier:@"thumbnail"];
        if (thumbnail_tc == nil) {
            NSLog(@"SCInstalledBalloonsList error : The table doesn¥'t have a NSTableColumn named [thumbnail].");
        }
        [thumbnail_tc setDataCell:ic];
        [[self tableBalloon] setAutosaveName:@"ghostmanager.balloontable.columns"];
        [[self tableBalloon] setAutosaveTableColumns:YES];
         */
        list=[[NSMutableArray alloc] init];
        [self reloadList];
    }
    return self;
}

-(void)setEnabled:(BOOL)boolflag{
    NSTableColumn *tc;
    NSTableView *tableBalloon = [[ghostManager windowController] tableBalloon];
    tc = [tableBalloon tableColumnWithIdentifier:@"select"];
    [[tc dataCell] setEnabled:boolflag];
    [tableBalloon setNeedsDisplay];
}

-(void)selectBalloon:(NSString *)balloon_path{
    // home/balloon/からのパスで指定されたバルーンを、リスト内のラジオボタンで選択します。
    // 見つからなかったらbuilt-inになります。
    NSUInteger n_items = [list count];
    int found_id = 0; // 0 = built-in
    for (int i = 0;i < n_items;i++) {
        if ([balloon_path isEqual:[(SCBalloonsListElement *)[list objectAtIndex:i] path]]) {
            // 見つけた
            found_id = i+1;
            break;
        }
    }
    selected_item = found_id;
    
    NSTableView *tableBalloon = [[ghostManager windowController] tableBalloon];
    [tableBalloon reloadData];
    [tableBalloon scrollColumnToVisible:found_id];
}

-(void)reloadList{
    NSTableView *tableBalloon = [[ghostManager windowController] tableBalloon];
    [tableBalloon deselectAll:self];
    [list removeAllObjects];
    
    NSString *bundleDir=[[SCFoundation sharedFoundation] getParentDirOfBundle];
    NSString *ghostDir=[bundleDir stringByAppendingPathComponent:@"home/balloon"];
    
    NSFileManager *sharedFM = [NSFileManager defaultManager];
    BOOL isDir;
    if ([sharedFM fileExistsAtPath:ghostDir isDirectory:&isDir] && isDir) {
        NSDirectoryEnumerator *dirEnumerator = [sharedFM enumeratorAtURL:[NSURL URLWithString:ghostDir]
                                              includingPropertiesForKeys:[NSArray arrayWithObjects:NSURLNameKey,NSURLIsDirectoryKey,nil]
                                                                 options:NSDirectoryEnumerationSkipsSubdirectoryDescendants|NSDirectoryEnumerationSkipsHiddenFiles
                                                            errorHandler:nil];
        
        // Enumerate the dirEnumerator results, each value is stored in allURLs
        for (NSURL *theURL in dirEnumerator) {
            
            // Retrieve the file name. From NSURLNameKey, cached during the enumeration.
            NSString *fileName;
            [theURL getResourceValue:&fileName forKey:NSURLNameKey error:NULL];
            
            // Retrieve whether a directory. From NSURLIsDirectoryKey, also
            // cached during the enumeration.
            NSNumber *isDirectory;
            [theURL getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:NULL];
            
            // Ignore files under the _extras directory
            if ([isDirectory boolValue]==YES)
            {
                NSString *pathDescriptTxt = [ghostDir stringByAppendingPathComponent:[fileName stringByAppendingPathComponent:@"descript.txt"]];
                
                if ([sharedFM fileExistsAtPath:pathDescriptTxt]) {
                    SCBalloonsListElement *le=[[SCBalloonsListElement alloc] initWithPath:[ghostDir stringByAppendingPathComponent:fileName]];
                    [list addObject:le];
                }
            }
            
            int maxHeight = [self getMaxHeightOfThumbnails];
            [tableBalloon setRowHeight:(maxHeight > 18 ? maxHeight : 18)];

            [tableBalloon reloadData];
        }
    }
    return;
}

-(int)getMaxHeightOfThumbnails{
    // リスト中の全てのサムネイル画像のうち、最も高さの大きな画像の高さを返します。
	int result = 0;
	
    NSUInteger n_elems = [list count];
	for (int i = 0;i < n_elems;i++) {
	    SCBalloonsListElement *le = (SCBalloonsListElement *)[list objectAtIndex:i];
	    if ([le thumbnail] != nil) {
            int h = (int)[[le thumbnail] size].height;
            if (h > result) result = h;
	    }
	}
	
	return result;
}

#pragma mark implementaion of NSTableView.DataSource
-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    if (list==nil) {
        return  0;
    }
    return [list count]+1;
}

-(BOOL)tableView:(NSTableView *)tableView acceptDrop:(id<NSDraggingInfo>)info row:(NSInteger)row dropOperation:(NSTableViewDropOperation)dropOperation{
    return NO;
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)rowIndex{
    NSString *column_id=[tableColumn identifier];
    if ([column_id isEqual:@"select"]) {
        //NSLog(@"%d,%lU",selected_item,(long)rowIndex);
        return (selected_item == rowIndex ? @"1" : @"0");
        //return @"1";
    }
    else if ([column_id isEqual:@"thumbnail"]) {
        if (rowIndex == 0) {
            return nil;
	    }
        else
        {
        SCBalloonsListElement *elem=(SCBalloonsListElement*)[list objectAtIndex:rowIndex-1];
        return [elem thumbnail];
        }
        
    }
    else if ([column_id isEqual:@"name"]) {
        if (rowIndex == 0) {
            return @"[built-in]";
	    }
        else
        {
            SCBalloonsListElement *elem=(SCBalloonsListElement*)[list objectAtIndex:rowIndex-1];
            return [elem name];
        }
    }
    return @"";
}

@end
