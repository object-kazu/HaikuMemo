//
//  Haiku.h
//  HaikuMemo
//
//  Created by 清水 一征 on 13/04/16.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Haiku : NSManagedObject

@property (nonatomic, retain) NSNumber    *child;
@property (nonatomic, retain) NSDate      *date;
@property (nonatomic, retain) NSString    *haiku575;
@property (nonatomic, retain) NSString    *identifer;
@property (nonatomic, retain) NSData      *image;
@property (nonatomic, retain) NSString    *kami5;
@property (nonatomic, retain) NSString    *naka7;
@property (nonatomic, retain) NSString    *shimo5;
@property (nonatomic, retain) NSData      *thumbnail;
@property (nonatomic, retain) NSString    *deleteFlug;

@end
