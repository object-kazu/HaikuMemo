//
//  KSCalc.m
//  HaikuMemo
//
//  Created by 清水 一征 on 13/03/23.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import "KSCalc.h"

@implementation KSCalc

- (NSDate *)componentsYearMonthDay:(NSDate *)comp_date {
    NSDateComponents    *dcomp = [self separateDateComponets:comp_date];
    
    NSCalendar          *calendar    = [NSCalendar currentCalendar];
    NSDateComponents    *compornents = [[NSDateComponents alloc]init];
    [compornents setYear:dcomp.year];
    [compornents setMonth:dcomp.month];
    [compornents setDay:dcomp.day];
    NSDate    *_date_ = [calendar dateFromComponents:compornents];
    
    compornents = nil;
    
    return _date_;
}

- (NSDateComponents *)separateDateComponets:(NSDate *)date {
    // デフォルトのカレンダーを取得
    NSCalendar          *calendar = [NSCalendar currentCalendar];
    
    // 日時をカレンダーで年月日時分秒に分解する
    NSDateComponents    *dateComps = [calendar components:
                                      NSYearCalendarUnit   |
                                      NSMonthCalendarUnit  |
                                      NSDayCalendarUnit    |
                                      NSHourCalendarUnit   |
                                      NSMinuteCalendarUnit |
                                      NSSecondCalendarUnit
                                                 fromDate:date];
    
    //    NSLog(@"separateDateComponets:%d/%02d/%02d",  dateComps.year, dateComps.month, dateComps.day);
    
    return dateComps;
}

- (NSString *)displayDateFormatted:(NSDate *)date {
    NSDateComponents    *comp = [self separateDateComponets:date];
    
    return [NSString stringWithFormat:@"%d/%02d/%02d", comp.year, comp.month, comp.day];
}

- (BOOL)isNewestDate:(NSDate *)base newest:(NSDate *)newest {
    
    NSTimeInterval    since = [newest timeIntervalSinceDate:base];
    
    BOOL              isNewest;
    if ( since > 0 ) {
        NSLog(@"new one");
        isNewest = TRUE;
    } else {
        NSLog(@"%f", since);
        isNewest = FALSE;
    }
    
    return isNewest;
}

- (SEASON)selectSeason:(NSDate *)date {
    NSDateComponents    *comp = [self separateDateComponets:date];
    
    if ( 4 <= comp.month && comp.month <= 6 ) {
        return SEASON_SPRING;
    }
    
    if ( 7 <= comp.month && comp.month <= 9 ) {
        return SEASON_SUMMER;
    }
    
    if ( 10 <= comp.month && comp.month <= 12 ) {
        return SEASON_AUTUM;
    }
    
    if ( 1 <= comp.month && comp.month <= 3 ) {
        return SEASON_WINTER;
    } else {
        return SEASON_OUT;
    }
    
}

@end
