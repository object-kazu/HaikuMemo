//
//  KSCalcTest.h
//  HaikuMemo
//
//  Created by 清水 一征 on 13/04/03.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "def.h"
#import "KSCalc.h"

@interface KSCalcTest : SenTestCase


@property (nonatomic,retain) KSCalc* calc;
@property (nonatomic, retain) NSDate* target;
@end
