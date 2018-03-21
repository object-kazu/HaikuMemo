//
//  KSKansuujiTest.m
//  HaikuMemo
//
//  Created by 清水 一征 on 13/04/07.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import "KSKansuujiTest.h"

@implementation KSKansuujiTest

- (void)setUp
{
    
    [super setUp];
    _kansuji = [[KSKansuuji alloc]init];
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *compornents = [[NSDateComponents alloc]init];
    [compornents setYear:1989];
    [compornents setMonth:7];
    [compornents setDay:25];
    _target = [calendar dateFromComponents:compornents];
    
    compornents =nil;
    
}

- (void)tearDown
{
    // Tear-down code here.
    _target = nil;
    _kansuji = nil;
    
    
    [super tearDown];
}


//-(void)test_dateForHaiku{
//    KSCalc* calc = [[KSCalc alloc]init];
//    NSDateComponents* dateComps = [calc separateDateComponets:_target];
//
//    NSString* result = [_kansuji dateForHaikuMemo:dateComps.year month:dateComps.month day:dateComps.day];
//    NSString* answer = @"文月二五日・一九八九 ";

//    STAssertTrue([result isEqualToString:answer], nil);
//    
//    
//    
//    calc =nil;
//}

-(void)test_suKanTranslate{
    NSString* testStr = @"1976";
    NSString* result = [_kansuji suKanTranslate:testStr];
    STAssertTrue([result isEqualToString:@"一九七六"],nil);
    
    testStr = @"2014";
    result = [_kansuji suKanTranslate:testStr];
    STAssertTrue([result isEqualToString:@"二〇一四"], nil);
    
}

-(void)test_Watuki{
    STAssertTrue([[_kansuji waTuki:1] isEqualToString:@"睦月"],nil);
    STAssertTrue([[_kansuji waTuki:0] isEqualToString:@"non"], nil);
    STAssertTrue([[_kansuji waTuki:13] isEqualToString:@"non"], nil);
    STAssertTrue([[_kansuji waTuki:12] isEqualToString:@"師走"], nil);
    
    
}
-(void) test_SuKanTranslateByUnit{
    NSString* kan = [_kansuji suKanTranslateByUnit:@"a"];
    STAssertTrue([kan isEqualToString:@"NO"], nil);
    kan = [_kansuji suKanTranslateByUnit:@"9"];
    STAssertTrue([kan isEqualToString:@"九"], nil);
    kan = [_kansuji suKanTranslateByUnit:@"0"];
    STAssertTrue([kan isEqualToString:@"〇"], nil);
}



@end
