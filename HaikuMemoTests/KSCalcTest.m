//
//  KSCalcTest.m
//  HaikuMemo
//
//  Created by 清水 一征 on 13/04/03.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import "KSCalcTest.h"

@implementation KSCalcTest

#define YEAR    1919
#define MONTH   7
#define DAY     19

- (void)setUp
{
    
    [super setUp];
    _calc = [[KSCalc alloc]init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *compornents = [[NSDateComponents alloc]init];
    [compornents setYear:YEAR];
    [compornents setMonth:MONTH];
    [compornents setDay:DAY];
    _target = [calendar dateFromComponents:compornents];
    
    compornents =nil;
    
}

- (void)tearDown
{
    // Tear-down code here.
    _calc = nil;
    _target = nil;
    
    [super tearDown];
}



-(void) test_CompronentsYearMonthDay{

    NSDate* treated = [_calc componentsYearMonthDay:_target];
    STAssertEqualObjects(_target, treated, nil);
    
}

-(void) test_SeparateDateComponents{

    NSDateComponents* comp = [_calc separateDateComponets:_target];
    STAssertEquals(comp.year, YEAR, nil);
    STAssertEquals(comp.month, MONTH, nil);
    STAssertEquals(comp.day, DAY, nil);
}

-(void) test_displayDateFormatted{

    NSString* str = [_calc displayDateFormatted:_target];
    NSString* answer = [NSString stringWithFormat:@"%d/%02d/%02d", YEAR,MONTH,DAY];

    STAssertEqualObjects(str, answer, nil);
    STAssertTrue([str isEqualToString:answer], nil);

}

-(void)test_isNewestDate{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *compornents = [[NSDateComponents alloc]init];
    [compornents setYear:2000];
    [compornents setMonth:MONTH];
    [compornents setDay:DAY];
    NSDate* newDate = [calendar dateFromComponents:compornents];
    
    //2000年と１９１９年を比較
    STAssertTrue([_calc isNewestDate:_target newest:newDate], nil);
    STAssertFalse([_calc isNewestDate:newDate newest:_target], nil);

}
-(void) test_Season_selection_WINTER{
 
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *compornents = [[NSDateComponents alloc]init];
    [compornents setYear:YEAR];
    [compornents setMonth:1];
    [compornents setDay:DAY];
    _target = [calendar dateFromComponents:compornents];
    
    STAssertEquals(SEASON_WINTER, [_calc selectSeason:_target], nil);
    

    [compornents setMonth:2];
    _target = [calendar dateFromComponents:compornents];
    STAssertEquals(SEASON_WINTER, [_calc selectSeason:_target], nil);

    [compornents setMonth:3];
    _target = [calendar dateFromComponents:compornents];
    STAssertEquals(SEASON_WINTER, [_calc selectSeason:_target], nil);

    [compornents setMonth:4];
    _target = [calendar dateFromComponents:compornents];
    SEASON sea = [_calc selectSeason:_target];
    STAssertFalse(SEASON_WINTER == sea, nil);
    
    
    compornents =nil;

}

-(void) test_Season_selection_SPRING{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *compornents = [[NSDateComponents alloc]init];
    [compornents setYear:YEAR];
    [compornents setMonth:4];
    [compornents setDay:DAY];
    _target = [calendar dateFromComponents:compornents];
    
    STAssertEquals(SEASON_SPRING, [_calc selectSeason:_target], nil);
    
    
    [compornents setMonth:5];
    _target = [calendar dateFromComponents:compornents];
    STAssertEquals(SEASON_SPRING, [_calc selectSeason:_target], nil);
    
    [compornents setMonth:6];
    _target = [calendar dateFromComponents:compornents];
    STAssertEquals(SEASON_SPRING, [_calc selectSeason:_target], nil);
    
    [compornents setMonth:7];
    _target = [calendar dateFromComponents:compornents];
    SEASON sea = [_calc selectSeason:_target];
    STAssertFalse(SEASON_SPRING == sea, nil);
    
    
    compornents =nil;
    
}

-(void) test_Season_selection_SUMMER{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *compornents = [[NSDateComponents alloc]init];
    [compornents setYear:YEAR];
    [compornents setMonth:7];
    [compornents setDay:DAY];
    _target = [calendar dateFromComponents:compornents];
    
    STAssertEquals(SEASON_SUMMER, [_calc selectSeason:_target], nil);
    
    
    [compornents setMonth:8];
    _target = [calendar dateFromComponents:compornents];
    STAssertEquals(SEASON_SUMMER, [_calc selectSeason:_target], nil);
    
    [compornents setMonth:9];
    _target = [calendar dateFromComponents:compornents];
    STAssertEquals(SEASON_SUMMER, [_calc selectSeason:_target], nil);
    
    [compornents setMonth:10];
    _target = [calendar dateFromComponents:compornents];
    SEASON sea = [_calc selectSeason:_target];
    STAssertFalse(SEASON_SUMMER == sea, nil);
    
    
    compornents =nil;
    
}

-(void) test_Season_selection_AUTUM{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *compornents = [[NSDateComponents alloc]init];
    [compornents setYear:YEAR];
    [compornents setMonth:10];
    [compornents setDay:DAY];
    _target = [calendar dateFromComponents:compornents];
    
    STAssertEquals(SEASON_AUTUM, [_calc selectSeason:_target], nil);
    
    
    [compornents setMonth:11];
    _target = [calendar dateFromComponents:compornents];
    STAssertEquals(SEASON_AUTUM, [_calc selectSeason:_target], nil);
    
    [compornents setMonth:12];
    _target = [calendar dateFromComponents:compornents];
    STAssertEquals(SEASON_AUTUM, [_calc selectSeason:_target], nil);
    
    [compornents setMonth:1];
    _target = [calendar dateFromComponents:compornents];
    SEASON sea = [_calc selectSeason:_target];
    STAssertFalse(SEASON_AUTUM == sea, nil);
    
    
    compornents =nil;
    
}


@end
