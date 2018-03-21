//
//  KSCalc.h
//  HaikuMemo
//
//  Created by 清水 一征 on 13/03/23.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "def.h"

@interface KSCalc : NSObject

- (NSDate *)componentsYearMonthDay:(NSDate *)comp_date;
- (NSDateComponents *)separateDateComponets:(NSDate *)date;
- (NSString *)displayDateFormatted:(NSDate *)date;
- (BOOL)isNewestDate:(NSDate *)base newest:(NSDate *)newest;
- (SEASON)selectSeason:(NSDate *)date;

@end
