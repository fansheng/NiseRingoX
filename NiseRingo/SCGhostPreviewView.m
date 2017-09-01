//
//  SCGhostPreviewView.m
//  NiseRingo
//
//  Created by apple  on 13-2-5.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SCGhostPreviewView.h"
#import "SCAlphaConverter.h"

@implementation SCGhostPreviewView
@synthesize messageBGColor;

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *bgimage_path = [defaults stringForKey:@"display.ghostmanager.preview.filepath"];
        if (bgimage_path == nil) bgimage_path = @"/Library/Desktop Pictures/Solid Colors/Solid Aqua Blue.png";
        background = [[NSImage alloc] initWithContentsOfFile:bgimage_path];
        sakura = kero = nil;
        is_empty = YES;
        messageFont = [NSFont systemFontOfSize:10.0f];
        messageColor = [NSColor blackColor];
        self.messageBGColor = [NSColor colorWithCalibratedWhite:1.0f alpha:0.5f];
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
    float widthOfView = self.frame.size.width;
    float heightOfView = self.frame.size.height;
	
	// 縦横比を保ったまま背景画像を拡大/縮小する。
	// 縦か横のどちらかがViewの縦または横と合っていれば良い。
	// 背景画像は常にView全体を覆う。
	float ratio;
	float widthOfBG,heightOfBG;
    float orig_widthOfBG = background.size.width; 
    float orig_heightOfBG = background.size.height;
	// まずは横を合わせる。
	ratio = widthOfView / orig_widthOfBG;
	widthOfBG = (int)(orig_widthOfBG * ratio);
	heightOfBG = (int)(orig_heightOfBG * ratio);
	if (heightOfBG < heightOfView) { // 縦が足りなかったら
	    ratio = heightOfView / orig_heightOfBG;
	    widthOfBG = (int)(orig_widthOfBG * ratio);
	    heightOfBG = (int)(orig_heightOfBG * ratio);
	}
	NSSize newSize={widthOfBG,heightOfBG};
	if (ratio > 1.0) background.size = newSize;
	NSImageRep *rep = (NSImageRep*)background.representations[0];
	rep.size = newSize;
	
	// 右下に合わせて描画する。
	NSRect rectToComposite = NSMakeRect(widthOfBG - widthOfView,0,widthOfView,heightOfView);
	[background drawAtPoint:NSZeroPoint fromRect:rectToComposite operation:NSCompositeCopy fraction:1.0f];
    
	if (!is_empty) {
	    /*
         ¥s[0]が無くて¥s[10]だけあった場合：「Missing surface id 0.」と表示
         ¥s[0]があって¥s[10]が無かった場合：「Missing surface id 10.」と表示
         両方無かった場合「Missing surface both of id 0 and id 10.」と表示
         */
	    NSString *message = nil;
	    if (sakura == nil && kero != nil) {
            message = @"Missing surface id 0.";
	    }
	    else if (sakura != nil && kero == nil) {
            message = @"Missing surface id 10.";
	    }
	    else if (sakura == nil && kero == nil) {
            message = @"Missing surface both of id 0 and id 10.";
	    }
	    if (message != nil) {
            NSRange wholeRange = NSMakeRange(0,message.length);
            NSMutableAttributedString *astr = [[NSMutableAttributedString alloc] initWithString:message];
            [astr addAttribute:NSFontAttributeName value:messageFont range:wholeRange];
            [astr addAttribute:NSForegroundColorAttributeName value:messageColor range:wholeRange];
            NSSize sizeOfMessage = [astr size];
            
            NSSize messageAreaSize = {sizeOfMessage.width + 6,sizeOfMessage.height + 4};
            NSRect messageAreaRect = NSMakeRect(3,heightOfView - 3 - messageAreaSize.height,messageAreaSize.width,messageAreaSize.height);
            [messageBGColor set];
            [NSBezierPath fillRect:messageAreaRect];
            
            [astr drawAtPoint:NSMakePoint(messageAreaRect.origin.x + 3,messageAreaRect.origin.y + 2)];
            return; // 以降の処理はどちらか一方でも欠けていると非常に面倒。捨て。
	    }
	    
	    /*
         sakura.width + kero.widthが画面内に収まるまで縦横比固定で縮小するが、
         その時点でsakura.height又はkero.heightが画面内に収まっていなかったら
         高さの大きい方を基準に画面内に収まるように縮小する。
         */

	    double shell_ratio;
	    float widthOfSakura,heightOfSakura,widthOfKero,heightOfKero;
        float orig_widthOfSakura = sakura.size.width;
        float orig_heightOfSakura = sakura.size.height;
        float orig_widthOfKero = kero.size.width;
        float orig_heightOfKero = kero.size.height;
	    // まずは横に合わせる
	    shell_ratio = widthOfView / (orig_widthOfSakura + orig_widthOfKero);
	    widthOfSakura = (int)(orig_widthOfSakura * shell_ratio);
	    heightOfSakura = (int)(orig_heightOfSakura * shell_ratio);
	    widthOfKero = (int)(orig_widthOfKero * shell_ratio);
	    heightOfKero = (int)(orig_heightOfKero * shell_ratio);
	    if (heightOfSakura > heightOfView || heightOfKero > heightOfView) { // 縦がはみ出していたら
            float base_height = (orig_heightOfSakura > orig_heightOfKero ? orig_heightOfSakura : orig_heightOfKero); // 基準となる高さ
            shell_ratio = heightOfView / base_height;
            widthOfSakura = (int)(orig_widthOfSakura * shell_ratio);
            heightOfSakura = (int)(orig_heightOfSakura * shell_ratio);
            widthOfKero = (int)(orig_widthOfKero * shell_ratio);
            heightOfKero = (int)(orig_heightOfKero * shell_ratio);
	    }
	    NSSize newShellSize;
	    // sakura
	    newShellSize = NSMakeSize(widthOfSakura,heightOfSakura);
	    if (shell_ratio > 1.0) sakura.size = newShellSize;
	    ((NSImageRep*)sakura.representations[0]).size = newShellSize;
	    // kero
	    newShellSize = NSMakeSize(widthOfKero,heightOfKero);
	    if (shell_ratio > 1.0) kero.size = newShellSize;
	    ((NSImageRep*)kero.representations[0]).size = newShellSize;
	    
        //[sakura compositeToPoint:NSZeroPoint operation:NSCompositeSourceOver];
        [sakura drawAtPoint:NSZeroPoint fromRect:rectToComposite operation:NSCompositeSourceOver fraction:1.0f];
        [kero drawAtPoint:NSMakePoint(widthOfSakura, 0) fromRect:rectToComposite operation:NSCompositeSourceOver fraction:1.0f];
	}
}

-(void)setImage:(NSString *)shell_dir{
    // shell_dir : シェルディレクトリ。
	// ここから¥s[0]と¥s[10]を読んで表示する。
	// 欠落していた場合はその旨を表示する。
	is_empty = NO;
	
    NSFileManager *sharedFM = [NSFileManager defaultManager];
    if (![sharedFM fileExistsAtPath:shell_dir]){
	    sakura = kero = nil;
	    [self display];
	    return;
	}
	
	// surface${id}でエイリアスデータベースから検索し、見つかればそれを、見つからなければsurface${id}.pngファイルをロード。
	//SCAliasManager aliasFileNameTable = [SCAliasManager(new File(shell_dir,"alias.txt"));
	NSString *surfaceName;
	NSString *pngFile;
	//surfaceName = aliasFileNameTable.resolveAlias("surface0");
    surfaceName = @"surface0000";
	pngFile = [NSString stringWithFormat:@"%@/%@.png",shell_dir,surfaceName];
	if ([sharedFM fileExistsAtPath:pngFile]) {
	    [self setImage:pngFile byScope:0];
	}
	else {
	    //pngFile = SCSurfaceServer.findSurfacePngFile(shell_dir,0);
	    if (pngFile != nil) {
            [self setImage:pngFile byScope:0];
	    }
	    else {
            sakura = nil;
	    }
	}

	//surfaceName = aliasFileNameTable.resolveAlias("surface0");
    surfaceName = @"surface0010";
	pngFile = [NSString stringWithFormat:@"%@/%@.png",shell_dir,surfaceName];
	if ([sharedFM fileExistsAtPath:pngFile]) {
	    [self setImage:pngFile byScope:1];
	}
	else {
	    //pngFile = SCSurfaceServer.findSurfacePngFile(shell_dir,10);
	    if (pngFile != nil) {
            [self setImage:pngFile byScope:1];
	    }
	    else {
            kero = nil;
	    }
	}
     
	
	[self display];
}

-(void)setImage:(NSString *)pngFile
        byScope:(int)scope{
    // pngをロードして左上の座標で色抜き。同時にアルファチャンネルを持たせる。
	NSImage *image = [SCAlphaConverter convertImage:[[NSImage alloc] initByReferencingFile:pngFile]];
	
	// pnaが存在するか？
	NSString *pnaFile = [pngFile.stringByDeletingPathExtension stringByAppendingPathExtension:@"pna"];
    NSFileManager *sharedFM = [NSFileManager defaultManager];
    if ([sharedFM fileExistsAtPath:pnaFile]){
	    // pnaをロードしてアルファチャンネルにコピー
	    NSImage *pna = [[NSImage alloc] initByReferencingFile:pnaFile];
        [SCAlphaConverter attachAlpha:pna toImage:image];
	}
	
	if (scope == 0) {
	    sakura = image;
	}
	else if (scope == 1) {
	    kero = image;
	}
}

@end
