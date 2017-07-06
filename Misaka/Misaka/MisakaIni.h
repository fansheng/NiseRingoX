//
//  MisakaIni.h
//  Misaka
//
//  Created by apple  on 13-5-28.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MisakaIni : NSObject{
    NSMutableDictionary* root;
}

-(id)initWithFilename:(NSString*) filename;
-(id)getObjectForKey:(NSString*)key;


@end
