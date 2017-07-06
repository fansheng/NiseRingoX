//
//  SCGhostManager.m
//  NiseRingo
//
//  Created by apple  on 13-2-3.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCGhostManager.h"
#import "SCFoundation.h"
#import "SCGhostsListsElement.h"

@implementation SCGhostManager
@synthesize windowController;
@synthesize installedList;
@synthesize balloonsList;
@synthesize installedGhostList;

+(SCGhostManager *)sharedSCGhostManager{
    static SCGhostManager* sharedInstance = nil;
    @synchronized(self)  {
        if  (sharedInstance == nil) {
            sharedInstance=[[self alloc] init]; // assignment not done here
        }
    }
    return sharedInstance;
}

-(id)init{
    self=[super init];
    if (self) {
        //windowController = [[SCGhostManagerWindowController alloc] initWithSCGhostManager:self];
        
        //balloonsList=[[SCInstalledBalloonsList alloc] initWithSCGhostManager:self];
        //shellsList=[[SCShellsList alloc] initWithSCGhostManager:self];
        //installedList=[[SCInstalledGhostsList alloc] initWithSCGhostManager:self];
        
        installedGhostList=[[NSMutableArray alloc] init];
        [self reloadLists];
        
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ghostWillReload) name:@"installer.end" object:nil];
    }
    return self;
}

-(void)reloadLists{
    [self reloadinstalledGhostList];
    //[balloonsList reloadList];
}

-(void)reloadinstalledGhostList{
    [installedGhostList removeAllObjects];
    
    NSString *bundleDir=[[SCFoundation sharedFoundation] getParentDirOfBundle];
    NSString *ghostDir=[bundleDir stringByAppendingPathComponent:@"home/ghost"];
    
    NSLog(@"%@",bundleDir);
    
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
                NSString *path_from_home = [[NSString alloc] initWithFormat:@"home/ghost/%@",fileName];
                NSLog(@"%@",path_from_home);
                
                // process the document
                NSDictionary *ghostDefaults = [self ghostDefaults:path_from_home];
                
                id boot_flag_entry = [ghostDefaults objectForKey:@"boot_flag"];
                BOOL boot_flag =
                (boot_flag_entry != nil &&
                 ([boot_flag_entry integerValue] == 1 ? YES : NO ));
                
                NSString *balloon = (NSString*)[ghostDefaults objectForKey:@"balloon"];
                if (balloon == nil) balloon = @"";
                
                id scale_entry = [ghostDefaults objectForKey:@"scale"];
                NSInteger scale = (scale_entry == nil ? 1.0 : [scale_entry integerValue]);
                
                NSString *shell_dirname = (NSString*)[ghostDefaults objectForKey:@"shell_dirname"];
                if (shell_dirname == nil) shell_dirname = @"master";
                SCGhostsListsElement *le=[[SCGhostsListsElement alloc] initWithBootFlag: boot_flag Path:path_from_home BalloonPath:balloon ShellDirname:shell_dirname Scale:scale];
                [installedGhostList addObject:le];
            }
        }
    }
}


-(void)ghostWillReload:(NSNotification *)notification{
    [self reloadLists];
}

-(NSMutableDictionary*)ghostDefaults:(NSString*)path{
    // path : home/ghost/[^/]+
    // なんて中途半端な正規表現で書いてみたりする。
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [defaults dictionaryForKey:[@"ghost.pref." stringByAppendingString: path]];
    return (dic == nil ? [NSMutableDictionary dictionary] : [NSMutableDictionary dictionaryWithDictionary:dic]);
}

@end
