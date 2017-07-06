//
//  SCShellsList.m
//  NiseRingo
//
//  Created by apple  on 13-2-5.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCShellsList.h"
#import "SCGhostManager.h"
#import "SCFoundation.h"
#import "SCShellsListElement.h"

/*
 FIXME: 今のところSCShellsListのインスタンスは一つだけ用意して使い回しているが、
 本来ならSCInstalledGhostsListが項目数分のインスタンスを持っているべき。
 コンテクストメニューを開くたびにディレクトリ構成やdescript.txtを読み直す羽目になる。
 */
@implementation SCShellsList
-(id)initWithSCGhostManager:(SCGhostManager *)gm{
    self = [super init];
    if (self) {
        ghostManager=gm;
        
        SCGhostManagerWindowController* windowController=[ghostManager windowController];
        NSTableView *tableView = [windowController tableInstalled];
        
        [tableView setDataSource:self];
         
        list=[[NSMutableArray alloc] init];
    }
    return self;
}

-(void)setContent:(NSString *)ghostRoot{
    
    NSTableView *table_shell = [[ghostManager windowController] table_shell];
    [table_shell deselectAll:self];
    [list removeAllObjects];
    
    NSString *bundleDir=[[SCFoundation sharedFoundation] getParentDirOfBundle];
    NSString *ghostDir=[[bundleDir stringByAppendingPathComponent:ghostRoot] stringByAppendingPathComponent:@"shell"];
    
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
                    SCShellsListElement *le=[[SCShellsListElement alloc] initWithPath:[ghostDir stringByAppendingPathComponent:fileName]];
                    [list addObject:le];
                }
            }
            
            [table_shell reloadData];
        }
    }

    return;
}

#pragma mark implementaion of NSTableView.DataSource
-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return  0;
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)rowIndex{
    //NSString *column_id=[tableColumn identifier];
    return nil;
}

@end
