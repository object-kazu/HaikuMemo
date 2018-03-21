//
//  KSKansuuji.m
//  HaikuMemo
//
//  Created by 清水 一征 on 13/04/07.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import "KSKansuuji.h"

const NSString    *Suuji   = @"0123456789";
const NSString    *Kansuji = @"〇一二三四五六七八九";

#define Watuki [NSArray arrayWithObjects:@"睦月", @"如月", @"弥生", @"卯月", @"皐月", @"水無月", @"文月", @"葉月", @"長月", @"神無月", @"霜月", @"師走", nil]

@implementation KSKansuuji

- (NSString *)dateForHaikuMemo:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    
    NSString    *_date  =   @"";
    NSString    *_year  =   [NSString stringWithFormat:@"%d", year];
    NSString    *_month =   @"";
    NSString    *_day   =   [NSString stringWithFormat:@"%d", day];
    
    _year  =   [self suKanTranslate:_year];
    _day   =   [self suKanTranslate:_day];
    _month =   [self waTuki:month];
    
    _date = [NSString stringWithFormat:@"%@ %@日・%@", _month, _day, _year];
    
    return _date;
}

- (NSString *)suKanTranslate:(NSString *)numbers {
    NSString        *_kanSuji = @"";
    unsigned int    counter;
    for ( counter = 0; counter < [numbers length]; counter++ ) {
        NSString    *str = [numbers substringWithRange:NSMakeRange(counter, 1)];
        str      = [self suKanTranslateByUnit:str];
        _kanSuji = [NSString stringWithFormat:@"%@%@", _kanSuji, str];
        
    }
    
    return _kanSuji;
}

- (NSString *)suKanTranslateByUnit:(NSString *)num {
    
    NSInteger    isExistChar = [Suuji rangeOfString:num].length;
    if ( isExistChar == 0 ) return @"NO";
    
    NSRange      range   = [Suuji rangeOfString:num];
    NSString     *target = [Kansuji substringWithRange:range];
    
    return target;
}

- (NSString *)waTuki:(NSInteger)number {
    number--;
    
    if ( number < 0 || number >= 12 ) return @"non";
    
    return Watuki[number];
}

@end
