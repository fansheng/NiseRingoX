//
//  SCSurfaceDescription.h
//  NiseRingo
//
//  Created by apple  on 13-5-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

//ret key start(surface) array->parser int surfaceid ret arrary
#import "SCBlockedDescription.h"

@interface SCSurfaceDescription : SCBlockedDescription
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSArray *surfaceKeys;


@end
