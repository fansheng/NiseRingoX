//
//  SCPrefWindowController.h
//  NiseRingo
//
//  Created by apple  on 13-1-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SCPrefWindowController : NSWindowController<NSWindowDelegate>

@property (weak) IBOutlet NSButton *booting_check_oldest_type;
@property (weak) IBOutlet NSButton *booting_check_inverse_type;
@property (weak) IBOutlet NSButton *booting_check_ghost_thumbnail;
@property (weak) IBOutlet NSButton *booting_check_zeropoint_balloon;

@property (weak) IBOutlet NSButton *mailcheck_check_enable;
@property (weak) IBOutlet NSTextField *mailcheck_fld_server;
@property (weak) IBOutlet NSTextField *mailcheck_fld_username;
@property (weak) IBOutlet NSSecureTextField *mailcheck_fld_password;
@property (weak) IBOutlet NSButton *mailcheck_check_autocheck;
@property (weak) IBOutlet NSTextField *mailcheck_fld_autocheck_interval;

@property (weak) IBOutlet NSButton *sstp_switch;
@property (weak) IBOutlet NSMatrix *sstp_portselect;
@property (unsafe_unretained) IBOutlet NSTextView *sstp_logview;

@property (weak) IBOutlet NSTableView *plugin_list;

@property (weak) IBOutlet NSMatrix *display_sb_levelselect;
@property (weak) IBOutlet NSButton *display_sb_activate_on_script;
@property (weak) IBOutlet NSTextField *display_sb_fontnamefield;
@property (weak) IBOutlet NSTextField *display_sb_fontsizefield;
@property (weak) IBOutlet NSSlider *display_sb_slider_transparency;
@property (weak) IBOutlet NSTextField *display_sb_fld_transparency;
@property (weak) IBOutlet NSButton *display_sb_balloon_fadeout;
@property (weak) IBOutlet NSButton *display_sb_balloon_clickthrough;
@property (weak) IBOutlet NSSlider *display_sb_slider_waitrate;
@property (weak) IBOutlet NSTextField *display_sb_fld_waitrate;

@property (weak) IBOutlet NSTextField *display_gm_preview_fpath;

@property (weak) IBOutlet NSButton *misc_always_show_vanish;
@property (weak) IBOutlet NSButton *misc_delete_after_online_install;
@property (weak) IBOutlet NSButton *misc_load_whole_surfaces;
@property (weak) IBOutlet NSButton *misc_disable_seriko_animation;
@property (weak) IBOutlet NSButton *misc_show_dev_interfaces;
@property (weak) IBOutlet NSTextField *misc_lightmode_on_sstp;
@property (weak) IBOutlet NSButton *misc_reset_surface_on_sstp;

+(SCPrefWindowController *)sharedPrefWindowController;

/******** callback methods ********/
-(void)_font_changed;

/************* actions ************/
- (IBAction)sstp_switch:(id)sender;
- (IBAction)sstp_portselect:(id)sender;
- (IBAction)display_sb_levelselect:(id)sender;
- (IBAction)display_sb_activate_on_script:(id)sender;
- (IBAction)display_sb_balloon_fadeout:(id)sender;
- (IBAction)display_sb_showfontpanel:(id)sender;
- (IBAction)display_sb_slider_transparency:(id)sender;
- (IBAction)display_sb_slider_waitrate:(id)sender;
- (IBAction)display_gm_preview_select:(id)sender;
- (IBAction)misc_always_show_vanish:(id)sender;
- (IBAction)misc_delete_after_online_install:(id)sender;


@end
