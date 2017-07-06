//
//  SCPrefWindowController.m
//  NiseRingo
//
//  Created by apple  on 13-1-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCPrefWindowController.h"


@implementation SCPrefWindowController

+(SCPrefWindowController *)sharedPrefWindowController{
    static SCPrefWindowController* _sharedInstance = nil;
    @synchronized(self)  {
        if  (_sharedInstance == nil) {
            _sharedInstance=[[self alloc] init]; // assignment not done here
        }
    }
    return _sharedInstance;
}




- (id)init
{
    self = [super initWithWindowNibName:@"PrefWindow"];
    if (self) {
        // Initialization code here.
        //[[self plugin_list] setDataSource:self];
    }
    
    return self;
}

-(void)showWindow:(id)sender{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString *workstr;
    // defaultsから読み込みます。
	
    // 起動処理
    [[self booting_check_oldest_type] setIntegerValue:0];
    if ([defaults objectForKey:@"booting.converter.inverse_type"]==nil) {
        [[self booting_check_inverse_type] setIntegerValue:1];
    }
    else{
        [[self booting_check_inverse_type] setIntegerValue:[defaults integerForKey:@"booting.converter.inverse_type"]];
    }
    if ([defaults objectForKey:@"booting.converter.thumbnail"]==nil) {
        [[self booting_check_ghost_thumbnail] setIntegerValue:1];
    }
    else{
        [[self booting_check_ghost_thumbnail] setIntegerValue:[defaults integerForKey:@"booting.converter.thumbnail"]];
    }
    if ([defaults objectForKey:@"booting.converter.zeropoint_balloon"]==nil) {
        [[self booting_check_zeropoint_balloon] setIntegerValue:1];
    }
    else{
        [[self booting_check_zeropoint_balloon] setIntegerValue:[defaults integerForKey:@"booting.converter.zeropoint_balloon"]];
    }
    
    // メールチェック
    workstr=[defaults stringForKey:@"mailcheck_server"];
    [[self mailcheck_fld_server] setStringValue:(workstr==nil ? @"" : workstr)];
    workstr=[defaults stringForKey:@"mailcheck_username"];
    [[self mailcheck_fld_username] setStringValue:(workstr==nil ? @"" : workstr)];
    workstr=[defaults stringForKey:@"mailcheck_password"];
    [[self mailcheck_fld_password] setStringValue:(workstr==nil ? @"" : workstr)];
    
    [[self mailcheck_check_enable] setIntegerValue:[defaults integerForKey:@"mailcheck_check_enable"]];
    [[self mailcheck_check_autocheck] setIntegerValue:[defaults integerForKey:@"mailcheck_check_autocheck"]];
    [[self mailcheck_fld_autocheck_interval] setIntegerValue:[defaults integerForKey:@"mailcheck_autocheck_interval"]];
    
    // SSTP
    // エントリが存在しなければ0が返る→offの時も0が返る→デフォルトでonの方がいいと思うけど、面倒だから諦めようか。
    [[self sstp_switch] setIntegerValue:[defaults integerForKey:@"sstp_switch"]];
    
    NSInteger port = [defaults integerForKey:@"sstp_port"];
    if (port == 0) port = 11000;
    if (port == 11000) {
        [[self sstp_portselect] selectCellAtRow:0 column:0];
    }
    else {
        [[self sstp_portselect] selectCellAtRow:1 column:0];
    }
    
    // 表示
    //   シェル/バルーン
    NSInteger levelType = [defaults integerForKey:@"display_levelselect"];
    if (levelType == NSNormalWindowLevel) {
        // エントリが存在しなければ0が返る→NSWindow.NormalWindowLevelも0である。
        [[self display_sb_levelselect] selectCellAtRow:0 column:0];
    }
    else if (levelType == NSFloatingWindowLevel) {
        [[self display_sb_levelselect] selectCellAtRow:1 column:0];
    }
    else if (levelType == NSModalPanelWindowLevel) {
        [[self display_sb_levelselect] selectCellAtRow:2 column:0];
    }
    [[self display_sb_activate_on_script] setIntegerValue:[defaults integerForKey:@"display.activate_on_script"]];
	
    NSString *fontname = [defaults stringForKey:@"display_fontname"];
    if (fontname == nil) {
        fontname = @"Osaka";
    }
         
    float fontsize = [defaults floatForKey:@"display_fontsize"];
    if (fontsize == 0) {
        fontsize = 9.0f;
    }
    [[self display_sb_fontnamefield] setStringValue:fontname];
    [[self display_sb_fontsizefield] setFloatValue:fontsize];
    NSFontManager* fm = [NSFontManager sharedFontManager];
    [fm setSelectedFont:[NSFont fontWithName:fontname size:fontsize] isMultiple:NO];
    [fm setAction:@selector(_font_changed)];
    double display_transparency_val = [defaults doubleForKey:@"display_slider_transparency"]; // 未定義なら0。
    [[self display_sb_slider_transparency] setDoubleValue:display_transparency_val];
    
    double display_waitrate_val;
    if ([defaults objectForKey:@"display.balloon.wait_rate"] == nil) {
        display_waitrate_val = 1.0; // デフォルトで100%
    }
    else {
        display_waitrate_val = [defaults doubleForKey:@"display.balloon.wait_rate"];
    }
    [[self display_sb_slider_waitrate] setDoubleValue:display_waitrate_val];
    
    if ([defaults objectForKey:@"display.balloon.fadeout"] == nil) {
        [[self display_sb_balloon_fadeout] setIntegerValue:1]; // デフォルトでon。
    }
    else {
        [[self display_sb_balloon_fadeout] setIntegerValue:[defaults integerForKey:@"display.balloon.fadeout"]];
    }
    NSInteger ct = [defaults integerForKey:@"display.balloon.clickthrough"];
    //SCFoundation.BALLOON_USES_CLICK_THROUGH = (ct != 0);
    [[self display_sb_balloon_clickthrough] setIntegerValue:ct];
    //   ゴーストマネージャ
    NSString *bgimage_path =[defaults stringForKey:@"display.ghostmanager.preview.filepath"];
    if (bgimage_path == nil) bgimage_path = @"/Library/Desktop Pictures/Solid Colors/Solid Aqua Blue.png";
    [[self display_gm_preview_fpath] setStringValue:bgimage_path];
	
    // その他
    [[self misc_always_show_vanish] setIntegerValue:[defaults integerForKey:@"misc.always_show_vanish"]];
    [[self misc_delete_after_online_install] setIntegerValue:[defaults integerForKey:@"misc.delete_after_online_install"]];
    [[self misc_load_whole_surfaces] setIntegerValue:[defaults integerForKey:@"misc.load_whole_surfaces_on_booting_surface_server"]];
    [[self misc_disable_seriko_animation] setIntegerValue:[defaults integerForKey:@"misc.disable_seriko_animation"]];
    [[self misc_show_dev_interfaces] setIntegerValue:[defaults integerForKey:@"misc.show_dev_interfaces"]];
    [[self misc_lightmode_on_sstp] setIntegerValue:[defaults integerForKey:@"misc.lightmode_on_sstp"]];
    [[self misc_reset_surface_on_sstp] setIntegerValue:[defaults integerForKey:@"misc.reset_surface_on_sstp"]];
    
    [super showWindow:sender];
}

/******** delegate methods ********/
-(BOOL)windowShouldClose:(id)sender{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    // defaultsに保存します。
	
    // 起動処理

    [defaults setInteger:[[self booting_check_inverse_type] integerValue] forKey:@"booting.converter.inverse_type"];
    [defaults setInteger:[[self booting_check_ghost_thumbnail] integerValue] forKey:@"booting.converter.thumbnai"];
    [defaults setInteger:[[self booting_check_zeropoint_balloon] integerValue] forKey:@"booting.converter.zeropoint_balloon"];
	
    // メールチェック
    //mailcheck_update(null);
    
    // SSTP
    [defaults setInteger:[[self sstp_switch] integerValue] forKey:@"sstp_switch"];
    NSInteger sstp_sel_id = [[self sstp_portselect] selectedRow];
    int port = (sstp_sel_id == 0 ? 11000 : 9801);
    [defaults setInteger:port forKey:@"sstp_port"];
    
    // 表示
    //   シェル/バルーン
    int levelType = NSNormalWindowLevel;
    NSInteger sel_id = [[self display_sb_levelselect] selectedRow];
    if (sel_id == 1) {
        // sel_id == 0の時は省略。
        levelType = NSFloatingWindowLevel;
    }
    else if (sel_id == 2) {
        levelType = NSModalPanelWindowLevel;
    }
    [defaults setInteger:levelType forKey:@"display_levelselect"];
    //SCFoundation.ACTIVATE_WINDOWS_WHEN_RUNNING_SCRIPT =  ([[self display_sb_activate_on_script] integerValue] != 0);
    [defaults setInteger:[[self display_sb_activate_on_script] integerValue] forKey:@"display.activate_on_script"];
	
    NSFontManager* fm = [NSFontManager sharedFontManager];
    NSFont* newfont = [fm selectedFont];
    NSString *name = nil;
    float size = 9.0f;
    if (newfont != nil) {
        name = [newfont fontName];
        size = [newfont pointSize];
    }
    else {
        name = @"Osaka";
        size = 9.0f;
    }
    [defaults setObject:name forKey:@"display_fontname"];
    [defaults setFloat:size forKey:@"display_fontsize"];
    [defaults setInteger:[[self display_sb_balloon_fadeout] integerValue] forKey:@"display.balloon.fadeout"];
    [defaults setInteger:[[self display_sb_balloon_clickthrough] integerValue] forKey:@"display.balloon.clickthrough"];
    //SCFoundation.BALLOON_USES_CLICK_THROUGH = (display_sb_balloon_clickthrough.intValue() != 0);
    //   ゴーストマネージャ
    [defaults setObject:[[self display_gm_preview_fpath] stringValue] forKey:@"display.ghostmanager.preview.filepath"];
	
    // その他
    [defaults setInteger:[[self misc_always_show_vanish] integerValue] forKey:@"misc.always_show_vanish"];
    [defaults setInteger:[[self misc_delete_after_online_install] integerValue] forKey:@"misc.delete_after_online_install"];
    [defaults setInteger:[[self misc_load_whole_surfaces] integerValue] forKey:@"misc.load_whole_surfaces_on_booting_surface_server"];
    [defaults setInteger:[[self misc_disable_seriko_animation] integerValue] forKey:@"misc.disable_seriko_animation"];
    
    //SCFoundation.LOAD_WHOLE_SURFACES_ON_BOOTING_SURFACE_SERVER = (misc_load_whole_surfaces.intValue() == 1);
    //SCFoundation.STOP_SERIKO = (misc_disable_seriko_animation.intValue() == 1);
    [defaults setInteger:[[self misc_show_dev_interfaces] integerValue] forKey:@"misc.show_dev_interfaces"];
    [defaults setInteger:[[self misc_lightmode_on_sstp] integerValue] forKey:@"misc.lightmode_on_sstp"];
    [defaults setInteger:[[self misc_reset_surface_on_sstp] integerValue] forKey:@"misc.reset_surface_on_sstp"];
    
    [defaults synchronize];
    return YES; // falseを返せばクローズが食い止められる。
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

/******** callback methods ********/
-(void)_font_changed{
    // NSFontManagerから呼ばれます。
    NSFontManager *fm = [NSFontManager sharedFontManager];
    NSFont *newfont = [fm selectedFont];
    if (newfont == nil) return;
    
    NSString *name = [newfont fontName];
    float size = [newfont pointSize];
    
    [[self display_sb_fontnamefield] setStringValue:name];
    [[self display_sb_fontsizefield] setFloatValue:size];
    
    /*
    Vector session_list = SCFoundation.sharedFoundation().getSessionsList();
    for (Iterator ite = session_list.iterator(); ite.hasNext(); ) {
        SCSession session = (SCSession)ite.next();
        
        for (Iterator iter = session.getBalloonIterator(); iter.hasNext(); ) {
            ((SCSafetyBalloonController)iter.next()).requestChangeFont(newfont);
            
        }
    }
     */
}

/************* actions ************/

- (IBAction)sstp_switch:(id)sender {
}

- (IBAction)sstp_portselect:(id)sender {
}

- (IBAction)display_sb_levelselect:(id)sender {
}

- (IBAction)display_sb_activate_on_script:(id)sender {
}

- (IBAction)display_sb_balloon_fadeout:(id)sender {
}

- (IBAction)display_sb_showfontpanel:(id)sender {
}

- (IBAction)display_sb_slider_transparency:(id)sender {
}

- (IBAction)display_sb_slider_waitrate:(id)sender {
}

- (IBAction)display_gm_preview_select:(id)sender {
}

- (IBAction)misc_always_show_vanish:(id)sender {
}

- (IBAction)misc_delete_after_online_install:(id)sender {
}
@end
